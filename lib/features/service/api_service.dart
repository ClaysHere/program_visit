// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:program_visit/features/authentication/models/auth_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

// Callback function untuk memberi tahu UI saat token refresh gagal dan perlu re-login
typedef TokenRefreshFailureCallback = void Function();

enum UserType { admin, sales }

class ApiService with WidgetsBindingObserver {
  static final String _baseUrl = dotenv.env['BASE_URL']!;
  static String? _accessToken;
  static String? _refreshToken;
  static final _storage = FlutterSecureStorage();

  static Timer? _refreshTokenTimer;

  static bool _isRefreshingToken = false;
  static final StreamController<String?> _onTokenRefreshedController =
      StreamController.broadcast();
  static Stream<String?> get onTokenRefreshed =>
      _onTokenRefreshedController.stream;

  static TokenRefreshFailureCallback? onTokenRefreshFailure;

  // Metode baru untuk mendapatkan access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: 'access_token');
  }

  static Future<void> initTokens() async {
    _accessToken = await _storage.read(key: 'access_token');
    _refreshToken = await _storage.read(key: 'refresh_token');
    print(
      'Tokens initialized: accessToken=${_accessToken != null}, refreshToken=${_refreshToken != null}',
    );
  }

  static Future<void> _saveTokens(
    String accessToken,
    String refreshToken,
  ) async {
    await _storage.write(key: 'access_token', value: accessToken);
    await _storage.write(key: 'refresh_token', value: refreshToken);
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    print('Tokens saved.');
  }

  static Future<void> _clearTokens() async {
    await _storage.delete(key: 'access_token');
    await _storage.delete(key: 'refresh_token');
    _accessToken = null;
    _refreshToken = null;
    _stopRefreshTokenTimer();
    print('Tokens cleared.');
  }

  ApiService._internal() {
    WidgetsBinding.instance.addObserver(this);
  }

  static final ApiService _instance = ApiService._internal();

  factory ApiService() {
    return _instance;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('App Lifecycle State: $state');
    if (state == AppLifecycleState.paused) {
      _stopRefreshTokenTimer();
      print('Refresh token timer stopped (app paused).');
    } else if (state == AppLifecycleState.resumed) {
      print('App resumed, checking token validity...');
      _checkAndStartRefreshTokenProcess();
    }
  }

  static void _startRefreshTokenTimer(Duration delay) {
    _refreshTokenTimer?.cancel();
    if (delay.isNegative) {
      print(
        'Token already expired or very close, triggering immediate refresh.',
      );
      _checkAndStartRefreshTokenProcess();
      return;
    }
    _refreshTokenTimer = Timer(delay, () async {
      print('Refresh token timer fired, attempting to refresh token...');
      await refreshToken();
    });
    print('Refresh token timer started for ${delay.inSeconds} seconds.');
  }

  static void _stopRefreshTokenTimer() {
    _refreshTokenTimer?.cancel();
    _refreshTokenTimer = null;
  }

  static DateTime? _getAccessTokenExpiryDate(String? token) {
    if (token == null) {
      return null;
    }
    try {
      final decodedToken = JwtDecoder.decode(token);
      final expiryTimestamp = decodedToken['exp'];
      if (expiryTimestamp != null && expiryTimestamp is int) {
        return DateTime.fromMillisecondsSinceEpoch(expiryTimestamp * 1000);
      }
    } catch (e) {
      print('Error decoding JWT or getting expiry date: $e');
    }
    return null;
  }

  static Future<String?> refreshToken() async {
    if (_isRefreshingToken) {
      print('Token refresh already in progress, waiting for result...');
      return onTokenRefreshed.firstWhere(
        (token) => token != null || token == null,
      );
    }

    _isRefreshingToken = true;
    _stopRefreshTokenTimer();

    if (_refreshToken == null) {
      print(
        'No refresh token available. Clearing tokens and requiring re-login.',
      );
      await _clearTokens();
      _isRefreshingToken = false;
      _onTokenRefreshedController.add(null);
      onTokenRefreshFailure?.call();
      return null;
    }

    final url = Uri.parse('$_baseUrl/auth/refresh');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refresh_token': _refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newAccessToken = data['access_token'];
        final newRefreshToken = data['refresh_token'] ?? _refreshToken;
        await _saveTokens(newAccessToken, newRefreshToken);

        final expiryDate = _getAccessTokenExpiryDate(newAccessToken);
        if (expiryDate != null) {
          final timeLeft = expiryDate.difference(DateTime.now());
          final refreshDelay = timeLeft - const Duration(seconds: 40);
          _startRefreshTokenTimer(refreshDelay);
        } else {
          print(
            'Warning: Could not determine expiry date for new access token.',
          );
        }

        print('Token refreshed successfully.');
        _isRefreshingToken = false;
        _onTokenRefreshedController.add(newAccessToken);
        return newAccessToken;
      } else {
        print(
          'Failed to refresh token: ${response.statusCode} - ${response.body}',
        );
        await _clearTokens();
        _isRefreshingToken = false;
        _onTokenRefreshedController.add(null);
        onTokenRefreshFailure?.call();
        return null;
      }
    } catch (e) {
      print('Error refreshing token: $e');
      await _clearTokens();
      _isRefreshingToken = false;
      _onTokenRefreshedController.add(null);
      onTokenRefreshFailure?.call();
      return null;
    } finally {
      _isRefreshingToken = false;
    }
  }

  static Future<http.Response?> getProtectedData() async {
    if (_accessToken == null) {
      print('No access token available for protected data. Please login.');
      onTokenRefreshFailure?.call();
      return null;
    }

    final url = Uri.parse('$_baseUrl/protected-data');
    try {
      var response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $_accessToken'},
      );

      if (response.statusCode == 401) {
        print(
          'Access token expired or invalid (401). Attempting to refresh...',
        );
        final newAccessToken = await refreshToken();
        if (newAccessToken != null) {
          print('Retrying request with new access token.');
          response = await http.get(
            url,
            headers: {'Authorization': 'Bearer $newAccessToken'},
          );
          if (response.statusCode == 401) {
            print(
              'Request still unauthorized after refresh. Re-login required.',
            );
            onTokenRefreshFailure?.call();
            return null;
          }
          return response;
        } else {
          print('Failed to refresh token. Re-login required.');
          onTokenRefreshFailure?.call();
          return null;
        }
      } else if (response.statusCode == 200) {
        return response;
      } else {
        print(
          'Failed to fetch protected data: ${response.statusCode} - ${response.body}',
        );
        return null;
      }
    } catch (e) {
      print('Error fetching protected data: $e');
      return null;
    }
  }

  static Future<void> _checkAndStartRefreshTokenProcess() async {
    if (_accessToken == null || _refreshToken == null) {
      await initTokens();
      if (_accessToken == null || _refreshToken == null) {
        print('No tokens available to check, re-login might be needed.');
        onTokenRefreshFailure?.call();
        return;
      }
    }

    final expiryDate = _getAccessTokenExpiryDate(_accessToken);
    final now = DateTime.now();

    if (expiryDate == null || expiryDate.isBefore(now)) {
      print('Access token expired or invalid, initiating refresh.');
      await refreshToken();
    } else {
      final timeLeft = expiryDate.difference(now);
      print('Access token still valid for: ${timeLeft.inSeconds} seconds.');

      if (timeLeft.inMinutes < 1) {
        print('Access token less than 1 minute remaining, triggering refresh.');
        await refreshToken();
      } else {
        final refreshDelay = timeLeft - const Duration(seconds: 40);
        _startRefreshTokenTimer(refreshDelay);
      }
    }
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _onTokenRefreshedController.close();
  }

  static Future<AuthResponse?> login(String username, String password) async {
    final url = Uri.parse('$_baseUrl/auth/login');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final authResponse = AuthResponse.fromJson(data);
        await _saveTokens(authResponse.accessToken, authResponse.refreshToken);

        final expiryDate = _getAccessTokenExpiryDate(_accessToken);
        if (expiryDate != null) {
          final timeLeft = expiryDate.difference(DateTime.now());
          final refreshDelay = timeLeft - const Duration(minutes: 3);
          _startRefreshTokenTimer(refreshDelay);
        } else {
          print('Warning: Could not determine expiry date for access token.');
        }

        return authResponse;
      } else {
        print('Login gagal: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error selama login: $e');
      return null;
    }
  }

  static Future<bool> logout() async {
    if (_accessToken == null && _refreshToken == null) {
      print('Already logged out or no tokens found locally.');
      return true;
    }

    final url = Uri.parse('$_baseUrl/auth/logout');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refresh_token': _refreshToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        print('Logged out successfully from server.');
        await _clearTokens();
        return true;
      } else {
        print(
          'Logout failed on server: ${response.statusCode} - ${response.body}',
        );
        await _clearTokens();
        return false;
      }
    } catch (e) {
      print('Error during logout: $e');
      await _clearTokens();
      return false;
    }
  }

  static Future<bool> registerAdminDanSales({
    required String username,
    required String password,
    required String firstName,
    required String lastName,
    required UserType userType, // Menggunakan Enum UserType
    required String gender,
    required DateTime birthPlace, // Menggunakan DateTime
    required DateTime birthDate, // Menggunakan DateTime
    required String address,
    required String phone,
    required String email,
    required String city,
    required String religion,
    // photo_path (blob) tidak disertakan langsung di sini, biasanya diunggah terpisah atau sebagai base64 string
    required DateTime joinDate, // Menggunakan DateTime
    required bool isSuspended, // Menggunakan bool
    // input_code, created_at, update_code, updated_at biasanya diurus di backend
  }) async {
    // Menentukan endpoint berdasarkan userType
    // Asumsi backend memiliki endpoint terpisah untuk admin dan sales,
    // atau satu endpoint umum yang memproses userType dari body.
    // Jika backend Anda hanya memiliki satu endpoint (misal: /register/user),
    // Anda bisa mengubah ini menjadi: String endpoint = '/register/user';
    String endpoint;
    switch (userType) {
      case UserType.admin:
        endpoint = '/register/admin';
        break;
      case UserType.sales:
        endpoint = '/register/sales';
        break;
      // ignore: unreachable_switch_default
      default:
        print('Invalid user type provided.');
        return false;
    }

    final url = Uri.parse('$_baseUrl$endpoint');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
          'first_name': firstName,
          'last_name': lastName,
          'user_type':
              userType
                  .name, // Mengirimkan nama enum sebagai string ('admin' atau 'sales')
          'gender': gender,
          'birth_place':
              birthPlace
                  .toIso8601String(), // Konversi DateTime ke ISO 8601 String
          'birth_date':
              birthDate
                  .toIso8601String(), // Konversi DateTime ke ISO 8601 String
          'address': address,
          'phone': phone,
          'email': email,
          'city': city,
          'religion': religion,
          'join_date':
              joinDate
                  .toIso8601String(), // Konversi DateTime ke ISO 8601 String
          'is_suspended':
              isSuspended ? 1 : 0, // Mengirim 1 atau 0 sesuai tinyint di DB
          // 'photo_path': // Jika Anda mengirim photo_path sebagai base64 string, tambahkan di sini
          // 'input_code': '', // Jika perlu dikirim dari frontend
        }),
      );

      if (response.statusCode == 201) {
        // 201 Created is typical for successful creation
        return true;
      } else {
        print('Failed to register user: ${response.statusCode}');
        print('Response body: ${response.body}');
        return false;
      }
    } catch (e) {
      print('Error during user registration: $e');
      return false;
    }
  }
}
