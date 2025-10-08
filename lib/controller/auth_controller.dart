import 'package:flutter/material.dart';
import 'package:test/services/local_storage.dart';

class AuthController extends ChangeNotifier {
  final LocalStorageService _local = LocalStorageService();
  bool isLoggedIn = false;
  String? userEmail;

  Future<void> loadFromStorage() async {
    final creds = await _local.getCredentials();
    if (creds != null) {
      userEmail = creds['email'];
    }
    notifyListeners();
  }

  Future<bool> signup(String email, String password) async {
    await _local.saveCredentials(email, password);
    userEmail = email;
    isLoggedIn = true;
    notifyListeners();
    return true;
  }

  Future<bool> login(String email, String password) async {
    final creds = await _local.getCredentials();
    if (creds == null) {
      return false;
    }
    if (creds['email'] == email && creds['password'] == password) {
      isLoggedIn = true;
      userEmail = email;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    isLoggedIn = false;
    userEmail = null;
    notifyListeners();
  }
}
