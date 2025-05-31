enum UserType { admin, sales }

class RegisterUserModel {
  final int? id;
  final String username;
  final String
  password; // Potentially sensitive, handle with care (e.g., only for sending, not receiving)
  final String firstName;
  final String lastName;
  final UserType userType;
  final String gender;
  final String birthPlace;
  final DateTime? birthDate;
  final String address;
  final String phone;
  final String email;
  final String city;
  final String religion;
  final String? photoPath;
  final DateTime? joinDate;
  final bool isSuspended;
  final String? inputCode;
  final DateTime? createdAt;
  final String? updateCode;
  final DateTime? updatedAt;

  RegisterUserModel({
    this.id,
    required this.username,
    required this.password,
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

  // Factory constructor to create a User object from JSON (e.g., from API response)
  factory RegisterUserModel.fromJson(Map<String, dynamic> json) {
    return RegisterUserModel(
      id: json['id'] as int?,
      username: json['username'] as String,
      password:
          '', // Password should ideally not be sent back from the API for security
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      userType: UserType.values.firstWhere(
        (e) => e.name == json['user_type'],
        orElse: () => UserType.admin, // Default if user_type is unknown
      ),
      gender: json['gender'] as String,
      birthPlace: json['birth_place'] as String,
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
      isSuspended: (json['is_suspended'] as int) == 1,
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

  // Method to convert a User object to JSON (e.g., for sending to API)
  Map<String, dynamic> toJson() {
    return {
      // 'id': id, // ID is usually not sent when creating/updating
      'username': username,
      'password': password, // Ensure this is only for registration/login
      'first_name': firstName,
      'last_name': lastName,
      'user_type': userType.name,
      'gender': gender,
      'birth_place': birthPlace,
      'birth_date': birthDate?.toUtc().toIso8601String(),
      'address': address,
      'phone': phone,
      'email': email,
      'city': city,
      'religion': religion,
      'photo_path': photoPath,
      'join_date': joinDate?.toUtc().toIso8601String(),
      'is_suspended':
          isSuspended ? 1 : 0, // Convert bool to int for tinyint in DB
      'input_code': inputCode,
      'created_at': createdAt?.toIso8601String(),
      'update_code': updateCode,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
