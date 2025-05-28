// ignore_for_file: avoid_print

import 'dart:async'; // Import untuk Timer
import 'dart:convert';
import 'package:flutter/material.dart'; // Import untuk WidgetsBindingObserver
import 'package:http/http.dart' as http;
import 'package:program_visit/features/authentication/models/auth_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'; // Import secure storage
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jwt_decoder/jwt_decoder.dart'; // Import jwt_decoder

// Callback function untuk memberi tahu UI saat token refresh gagal dan perlu re-login
typedef TokenRefreshFailureCallback = void Function();

class ApiService with WidgetsBindingObserver {
  static final String _baseUrl = dotenv.env['BASE_URL']!;
  static String? _accessToken;
  static String? _refreshToken;
  static final _storage = FlutterSecureStorage(); // Instance secure storage

  // Timer untuk refresh token otomatis
  static Timer? _refreshTokenTimer;

  // Variabel untuk menangani concurrent refresh requests (race condition)
  static bool _isRefreshingToken = false;
  static final StreamController<String?> _onTokenRefreshedController =
      StreamController.broadcast();
  static Stream<String?> get onTokenRefreshed =>
      _onTokenRefreshedController.stream;

  // Callback jika refresh token gagal dan butuh re-login
  static TokenRefreshFailureCallback? onTokenRefreshFailure;

  // Inisialisasi token dari secure storage saat aplikasi dimulai
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
    _stopRefreshTokenTimer(); // Hentikan timer saat token dihapus
    print('Tokens cleared.');
  }

  // --- Penanganan Siklus Hidup Aplikasi (Lifecycle Management) ---
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
      // App masuk background
      _stopRefreshTokenTimer();
      print('Refresh token timer stopped (app paused).');
    } else if (state == AppLifecycleState.resumed) {
      // App kembali foreground
      print('App resumed, checking token validity...');
      _checkAndStartRefreshTokenProcess();
    }
  }

  // Panggil ini di main() atau di widget awal aplikasi Anda
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _onTokenRefreshedController.close();
  }

  // --- Fungsi Refresh Token Otomatis ---
  static void _startRefreshTokenTimer(Duration delay) {
    _refreshTokenTimer?.cancel(); // Pastikan timer sebelumnya di-cancel
    if (delay.isNegative) {
      // Jika delay negatif (token sudah kedaluwarsa atau sangat dekat), langsung refresh
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

  // Helper untuk mendapatkan waktu kedaluwarsa dari access token JWT
  static DateTime? _getAccessTokenExpiryDate(String? token) {
    if (token == null) {
      return null;
    }
    try {
      final decodedToken = JwtDecoder.decode(token);
      final expiryTimestamp =
          decodedToken['exp']; // 'exp' adalah timestamp Unix (dalam detik)
      if (expiryTimestamp != null && expiryTimestamp is int) {
        // Mengubah Unix timestamp (detik) ke DateTime (milidetik)
        return DateTime.fromMillisecondsSinceEpoch(expiryTimestamp * 1000);
      }
    } catch (e) {
      print('Error decoding JWT or getting expiry date: $e');
    }
    return null;
  }

  static Future<void> _checkAndStartRefreshTokenProcess() async {
    // Pastikan token sudah dimuat
    if (_accessToken == null || _refreshToken == null) {
      await initTokens(); // Coba muat dari storage jika belum ada
      if (_accessToken == null || _refreshToken == null) {
        print('No tokens available to check, re-login might be needed.');
        onTokenRefreshFailure?.call(); // Panggil callback untuk re-login
        return;
      }
    }

    final expiryDate = _getAccessTokenExpiryDate(_accessToken);
    final now = DateTime.now();

    // Jika expiryDate null (token tidak valid atau tidak memiliki 'exp') atau sudah kedaluwarsa
    if (expiryDate == null || expiryDate.isBefore(now)) {
      print('Access token expired or invalid, initiating refresh.');
      await refreshToken();
    } else {
      final timeLeft = expiryDate.difference(now);
      print('Access token still valid for: ${timeLeft.inSeconds} seconds.');

      if (timeLeft.inMinutes < 1) {
        // Jika sisa waktu kurang dari 1 menit (60 detik)
        print('Access token less than 1 minute remaining, triggering refresh.');
        await refreshToken();
      } else {
        // Set timer untuk refresh token 40 detik sebelum kadaluwarsa
        final refreshDelay = timeLeft - const Duration(seconds: 40);
        _startRefreshTokenTimer(refreshDelay);
      }
    }
  }

  // Fungsi untuk login
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

        // Setelah login berhasil, set timer untuk refresh
        final expiryDate = _getAccessTokenExpiryDate(_accessToken);
        if (expiryDate != null) {
          final timeLeft = expiryDate.difference(DateTime.now());
          // Set timer 3 menit sebelum token kedaluwarsa (sesuai diagram)
          final refreshDelay = timeLeft - const Duration(minutes: 3);
          _startRefreshTokenTimer(refreshDelay);
        } else {
          print('Warning: Could not determine expiry date for access token.');
        }

        return authResponse;
      } else {
        print('Login failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Error during login: $e');
      return null;
    }
  }

  // Fungsi untuk me-refresh token akses
  static Future<String?> refreshToken() async {
    // Mencegah multiple concurrent refresh requests
    if (_isRefreshingToken) {
      print('Token refresh already in progress, waiting for result...');
      // Tunggu hingga proses refresh yang sedang berjalan selesai
      return onTokenRefreshed.firstWhere(
        (token) => token != null || token == null,
      );
    }

    _isRefreshingToken = true;
    _stopRefreshTokenTimer(); // Hentikan timer saat refresh dimulai

    if (_refreshToken == null) {
      print(
        'No refresh token available. Clearing tokens and requiring re-login.',
      );
      await _clearTokens();
      _isRefreshingToken = false;
      _onTokenRefreshedController.add(null); // Beri tahu bahwa refresh gagal
      onTokenRefreshFailure?.call(); // Panggil callback untuk re-login
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
        final newRefreshToken =
            data['refresh_token'] ??
            _refreshToken; // Server bisa kirim refresh token baru atau tidak
        await _saveTokens(newAccessToken, newRefreshToken);

        // Setelah refresh berhasil, set timer baru
        final expiryDate = _getAccessTokenExpiryDate(newAccessToken);
        if (expiryDate != null) {
          final timeLeft = expiryDate.difference(DateTime.now());
          final refreshDelay =
              timeLeft -
              const Duration(
                seconds: 40,
              ); // Set timer 40 detik sebelum kadaluwarsa
          _startRefreshTokenTimer(refreshDelay);
        } else {
          print(
            'Warning: Could not determine expiry date for new access token.',
          );
        }

        print('Token refreshed successfully.');
        _isRefreshingToken = false;
        _onTokenRefreshedController.add(
          newAccessToken,
        ); // Beri tahu bahwa refresh berhasil
        return newAccessToken;
      } else {
        print(
          'Failed to refresh token: ${response.statusCode} - ${response.body}',
        );
        await _clearTokens();
        _isRefreshingToken = false;
        _onTokenRefreshedController.add(null); // Beri tahu bahwa refresh gagal
        onTokenRefreshFailure?.call(); // Panggil callback untuk re-login
        return null;
      }
    } catch (e) {
      print('Error refreshing token: $e');
      await _clearTokens();
      _isRefreshingToken = false;
      _onTokenRefreshedController.add(null); // Beri tahu bahwa refresh gagal
      onTokenRefreshFailure?.call(); // Panggil callback untuk re-login
      return null;
    } finally {
      // Pastikan _isRefreshingToken di-reset bahkan jika terjadi error tak terduga
      _isRefreshingToken = false;
    }
  }

  // Fungsi untuk logout
  static Future<bool> logout() async {
    if (_accessToken == null && _refreshToken == null) {
      print('Already logged out or no tokens found locally.');
      return true; // Sudah logout
    }

    final url = Uri.parse('$_baseUrl/auth/logout');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refresh_token': _refreshToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // 200 OK atau 204 No Content (Sukses di server)
        print('Logged out successfully from server.');
        await _clearTokens(); // Hapus token lokal
        return true;
      } else {
        print(
          'Logout failed on server: ${response.statusCode} - ${response.body}',
        );
        await _clearTokens(); // Meskipun gagal di server, tetap hapus token lokal
        return false;
      }
    } catch (e) {
      print('Error during logout: $e');
      await _clearTokens(); // Tetap hapus token lokal jika ada error jaringan dll.
      return false;
    }
  }

  // Contoh permintaan yang memerlukan otentikasi
  static Future<http.Response?> getProtectedData() async {
    if (_accessToken == null) {
      print('No access token available for protected data. Please login.');
      onTokenRefreshFailure?.call(); // Minta user re-login
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
        final newAccessToken =
            await refreshToken(); // Memanggil fungsi refresh token yang sudah menangani race condition
        if (newAccessToken != null) {
          print('Retrying request with new access token.');
          // Coba lagi dengan token baru
          response = await http.get(
            url,
            headers: {'Authorization': 'Bearer $newAccessToken'},
          );
          // Periksa kembali status code setelah retry
          if (response.statusCode == 401) {
            print(
              'Request still unauthorized after refresh. Re-login required.',
            );
            onTokenRefreshFailure?.call(); // Panggil callback untuk re-login
            return null;
          }
          return response;
        } else {
          print('Failed to refresh token. Re-login required.');
          onTokenRefreshFailure?.call(); // Panggil callback untuk re-login
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
}
