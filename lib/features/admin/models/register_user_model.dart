import 'package:program_visit/features/service/api_service.dart';

class RegisterUserModel {
  final int? id; // int [primary key]
  final String username; // varchar(30) UNIQUE
  final String
  password; // varchar(64) - Biasanya tidak dikirim kembali dari API
  final String firstName; // varchar(30)
  final String lastName; // varchar(30)
  final UserType userType; // user_type (enum)
  final String gender; // varchar(30)
  final String birthPlace; // varchar(30) - Mengoreksi dari DateTime ke String
  final DateTime? birthDate; // datetime
  final String address; // varchar(250)
  final String phone; // varchar(100)
  final String email; // varchar(100)
  final String city; // varchar(50)
  final String religion; // varchar(30)
  final String? photoPath; // blob - Asumsi URL atau base64 string
  final DateTime? joinDate; // date
  final bool isSuspended; // tinyint (0/1)
  final String? inputCode; // varchar(30)
  final DateTime? createdAt; // datetime
  final String? updateCode; // varchar(30)
  final DateTime? updatedAt; // datetime

  RegisterUserModel({
    this.id,
    required this.username,
    required this.password, // Password hanya untuk registrasi/login, tidak untuk model yang diterima dari API
    required this.firstName,
    required this.lastName,
    required this.userType,
    required this.gender,
    required this.birthPlace,
    this.birthDate,
    required this.address,
    required this.phone,
    required this.email,
    required this.city,
    required this.religion,
    this.photoPath,
    this.joinDate,
    required this.isSuspended,
    this.inputCode,
    this.createdAt,
    this.updateCode,
    this.updatedAt,
  });

  // Factory constructor untuk membuat objek User dari JSON (misalnya dari respons API)
  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserModel(
      id: json['id'] as int?,
      username: json['username'] as String,
      password: '', // Password tidak akan dikirim kembali dari API
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      userType: UserType.values.firstWhere(
        (e) => e.name == json['user_type'],
        orElse: () => UserType.admin, // Default jika user_type tidak dikenal
      ),
      gender: json['gender'] as String,
      birthPlace: json['birth_place'] as String, // String
      birthDate:
          json['birth_date'] != null
              ? DateTime.parse(json['birth_date'] as String)
              : null,
      address: json['address'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      city: json['city'] as String,
      religion: json['religion'] as String,
      photoPath: json['photo_path'] as String?,
      joinDate:
          json['join_date'] != null
              ? DateTime.parse(json['join_date'] as String)
              : null,
      isSuspended: (json['is_suspended'] as int) == 1, // Konversi int ke bool
      inputCode: json['input_code'] as String?,
      createdAt:
          json['created_at'] != null
              ? DateTime.parse(json['created_at'] as String)
              : null,
      updateCode: json['update_code'] as String?,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.parse(json['updated_at'] as String)
              : null,
    );
  }

  // Metode untuk mengonversi objek User menjadi JSON (misalnya untuk dikirim ke API)
  Map<String, dynamic> toJson() {
    return {
      // 'id': id, // ID biasanya tidak dikirim saat membuat/memperbarui
      'username': username,
      'password': password, // Pastikan ini hanya untuk registrasi/login
      'first_name': firstName,
      'last_name': lastName,
      'user_type': userType.name,
      'gender': gender,
      'birth_place': birthPlace, // String
      'birth_date': birthDate?.toIso8601String(),
      'address': address,
      'phone': phone,
      'email': email,
      'city': city,
      'religion': religion,
      'photo_path': photoPath,
      'join_date': joinDate?.toIso8601String(),
      'is_suspended': isSuspended ? 1 : 0, // Konversi bool ke int
      'input_code': inputCode,
      'created_at': createdAt?.toIso8601String(),
      'update_code': updateCode,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
