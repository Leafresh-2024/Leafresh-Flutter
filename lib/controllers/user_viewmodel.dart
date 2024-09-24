import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserViewModel extends ChangeNotifier {
  User? _user;
  bool _isLoggedIn = false;
  final ApiService _apiService = ApiService();

  User? get user => _user;
  bool get isLoggedIn => _isLoggedIn;

  Future<void> fetchUserProfile(String token) async {
    try {
      _user = await _apiService.fetchUserProfile(token);
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      _isLoggedIn = false;
      print("Error fetching user profile: $e");
    }
  }

  Future<void> logout(String token) async {
    await _apiService.logout(token);
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }
}
