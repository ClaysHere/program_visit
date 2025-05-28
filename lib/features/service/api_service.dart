// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:program_visit/features/authentication/models/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Impor flutter_dotenv

class ApiService {
  static final String _baseUrl = dotenv.env['BASE_URL']!;
  static String? _accessToken;
  static String? _refreshToken;

  // Inisialisasi token dari shared preferences saat aplikasi dimulai
  static Future<void> initTokens() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token');
    _refreshToken = prefs.getString('refresh_token');
  }

  static Future<void> _saveTokens(
    String accessToken,
    String refreshToken,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  static Future<void> _clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
    _accessToken = null;
    _refreshToken = null;
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
    if (_refreshToken == null) {
      print('No refresh token available.');
      await _clearTokens();
      return null;
    }

    final url = Uri.parse(
      '$_baseUrl/refresh-token',
    ); // Ganti dengan endpoint refresh token Anda
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer $_refreshToken', // Contoh: refresh token di header Authorization
          // Atau di body: body: json.encode({'refresh_token': _refreshToken})
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final newAccessToken = data['access_token'];
        final newRefreshToken = data['refresh_token'] ?? _refreshToken;
        await _saveTokens(newAccessToken, newRefreshToken);
        return newAccessToken;
      } else {
        print(
          'Failed to refresh token: ${response.statusCode} - ${response.body}',
        );
        await _clearTokens();
        return null;
      }
    } catch (e) {
      print('Error refreshing token: $e');
      await _clearTokens();
      return null;
    }
  }

  // Fungsi untuk logout
  static Future<bool> logout() async {
    if (_accessToken == null) return true; // Sudah logout

    final url = Uri.parse(
      '$_baseUrl/auth/logout',
    ); // Ganti dengan endpoint logout Anda
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'refresh_token': _refreshToken}),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // 200 OK atau 204 No Content
        await _clearTokens();
        return true;
      } else {
        print('Logout gagal: ${response.statusCode} - ${response.body}');
        await _clearTokens(); // Meskipun gagal di server, tetap hapus token lokal
        return false;
      }
    } catch (e) {
      print('Error selama logout: $e');
      await _clearTokens(); // Tetap hapus token lokal
      return false;
    }
  }

  // Contoh permintaan yang memerlukan otentikasi
  static Future<http.Response?> getProtectedData() async {
    if (_accessToken == null) {
      print('No access token available. Please login.');
      return null;
    }

    final url = Uri.parse(
      '$_baseUrl/protected-data',
    ); // Ganti dengan endpoint data yang dilindungi
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $_accessToken'},
      );

      if (response.statusCode == 401) {
        print('Access token expired or invalid. Attempting to refresh...');
        final newAccessToken = await refreshToken();
        if (newAccessToken != null) {
          return await http.get(
            url,
            headers: {'Authorization': 'Bearer $newAccessToken'},
          );
        } else {
          print('Failed to refresh token. Please re-login.');
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

  // Fungsi untuk registrasi (perlu disesuaikan dengan endpoint dan data yang dibutuhkan API Anda)
  // static Future<AuthResponse?> register(
  //   String username,
  //   String email,
  //   String password, {
  //   String? firstName,
  //   String? lastName,
  //   String? userType,
  // }) async {
  //   final url = Uri.parse('$_baseUrl/register');
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode({
  //         'username': username,
  //         'email': email,
  //         'password': password,
  //         'first_name': firstName,
  //         'last_name': lastName,
  //         'user_type':
  //             userType ?? 'Customer', // Default user_type jika tidak disediakan
  //         // Tambahkan bidang lain yang dibutuhkan oleh API registrasi Anda
  //       }),
  //     );

  //     if (response.statusCode == 201) {
  //       // Biasanya 201 Created untuk registrasi sukses
  //       final data = json.decode(response.body);
  //       final authResponse = AuthResponse.fromJson(data);
  //       await _saveTokens(authResponse.accessToken, authResponse.refreshToken);
  //       return authResponse;
  //     } else {
  //       print('Registration failed: ${response.statusCode} - ${response.body}');
  //       return null;
  //     }
  //   } catch (e) {
  //     print('Error during registration: $e');
  //     return null;
  //   }
  // }
}
