import 'package:flutter/material.dart';

class AuthController extends ChangeNotifier {
  final List<Map<String, dynamic>> _registeredUsers = [];
  Map<String, dynamic>? _currentUser;

  List<Map<String, dynamic>> get registeredUsers => _registeredUsers;
  Map<String, dynamic>? get currentUser => _currentUser;

  void register(String name, String email, String phone, String password) {
    _registeredUsers.add({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    });
    notifyListeners();
  }

  bool login(String email, String password) {
    final user = _registeredUsers.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );

    if (user.isNotEmpty) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }

  bool isEmailRegistered(String email) {
    return _registeredUsers.any((user) => user['email'] == email);
  }
}
