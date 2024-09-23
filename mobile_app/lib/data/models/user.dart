import 'dart:convert';

class User {
  User(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.password,
      required this.phone});

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;

  String toJson() {
    return jsonEncode({
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'email': email,
      'password': password
    });
  }
}
