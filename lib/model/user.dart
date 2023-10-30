import 'dart:convert';

enum Gender {
  Male,
  Female,
  other,
}

enum Role {
  doctor,
  user,
  admin,
}

class User {
  final String name;
  final String email;
  final String phone;
  final String location;
  final String gender;
  final String role;
  final String password;
  final String token;
  User({
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.gender,
    required this.role,
    required this.password,
    required this.token,
  });


  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'location': location,
      'gender': gender,
      'role': role,
      'password': password,
      'token': token,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phone: map['phone'] ?? '',
      location: map['location'] ?? '',
      gender: map['gender'] ?? '',
      role: map['role'] ?? '',
      password: map['password'] ?? '',
      token: map['token'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
