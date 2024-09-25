import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class UserViewModel extends ChangeNotifier {
  User? _user;
  bool _isLoggedIn = false;
  String? _token;

  final ApiService _apiService = ApiService();

  User? get user => _user;
  bool get isLoggedIn => _isLoggedIn;
  String? get token => _token;

  Future<void> login(String email, String password, BuildContext context) async {
    try {
      final response = await _apiService.login(email, password);
      if (response != null) {
        _token = response['accessToken'];
        await fetchUserProfile(_token!);
        _isLoggedIn = true;
        notifyListeners();
        Navigator.pushReplacementNamed(context, '/community'); // 로그인 후 커뮤니티 페이지로 이동
      }
    } catch (e) {
      _isLoggedIn = false;
      print("로그인 에러: $e");
    }
  }

  Future<void> fetchUserProfile(String token) async {
    try {
      final fetchedUser = await _apiService.fetchUserProfile(token);
      if (fetchedUser != null) {
        _user = fetchedUser;
      } else {
        throw Exception('프로필 데이터를 불러오지 못했습니다.');
      }
      notifyListeners();
    } catch (e) {
      print("프로필 조회 에러: $e");
    }
  }


  Future<void> logout(BuildContext context) async {
    if (_token != null) {
      await _apiService.logout(_token!);
      _token = null;
      _user = null;
      _isLoggedIn = false;
      notifyListeners();
      Navigator.pushReplacementNamed(context, '/login'); // 로그아웃 후 로그인 페이지로 이동
    }
  }

  // 유저 이메일을 통해서 유저 정보를 불러온다.
  Future<void> fetchUserByEmail(String email) async {

    try{
      final response = await ApiService().fetchUserProfileByEmail(_token!, email);
      if (response != null) {
        _user = response;
        notifyListeners();
      }
    } catch (e) {
      print("유저정보 조회실패: $e");
    }

  }



}
