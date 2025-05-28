// ignore: unused_import
import 'dart:convert';

// Model untuk merepresentasikan respons login/registrasi
class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final User user;

  AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'user': user.toJson(),
    };
  }
}

// Model untuk merepresentasikan data pengguna
class User {
  final int id;
  final String username;
  final String userType;
  final String? firstName;
  final String? lastName;
  final String? gender;
  final String? birthPlace;
  final DateTime? birthDate;
  final String? address;
  final String? phone;
  final String? email;
  final String? city;
  final String? religion;
  final String?
  photoPath; // blob biasanya diwakili oleh String path atau base64
  final DateTime? joinDate;
  final bool isSuspended;
  final String? inputCode;
  final DateTime createdAt;
  final String? updateCode;
  final DateTime? updatedAt;

  User({
    required this.id,
    required this.username,
    required this.userType,
    this.firstName,
    this.lastName,
    this.gender,
    this.birthPlace,
    this.birthDate,
    this.address,
    this.phone,
    this.email,
    this.city,
    this.religion,
    this.photoPath,
    this.joinDate,
    required this.isSuspended,
    this.inputCode,
    required this.createdAt,
    this.updateCode,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      userType: json['user_type'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      gender: json['gender'],
      birthPlace: json['birth_place'],
      birthDate:
          json['birth_date'] != null
              ? DateTime.parse(json['birth_date'])
              : null,
      address: json['address'],
      phone: json['phone'],
      email: json['email'],
      city: json['city'],
      religion: json['religion'],
      photoPath: json['photo_path'],
      joinDate:
          json['join_date'] != null ? DateTime.parse(json['join_date']) : null,
      isSuspended:
          json['is_suspended'], // API response is_suspended is boolean directly
      inputCode: json['input_code'],
      createdAt: DateTime.parse(json['created_at']),
      updateCode: json['update_code'],
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'user_type': userType,
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'birth_place': birthPlace,
      'birth_date': birthDate?.toIso8601String(),
      'address': address,
      'phone': phone,
      'email': email,
      'city': city,
      'religion': religion,
      'photo_path': photoPath,
      'join_date': joinDate?.toIso8601String(),
      'is_suspended': isSuspended, // Kembalikan sebagai boolean
      'input_code': inputCode,
      'created_at': createdAt.toIso8601String(),
      'update_code': updateCode,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
