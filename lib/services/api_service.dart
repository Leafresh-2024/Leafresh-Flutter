import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080';

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));

    } else {
      throw Exception('로그인 실패: ${response.statusCode}');
    }
  }


  Future<User?> fetchUserProfile(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/me'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load user profile');
    }
  }

  // 커뮤니티 피드 목록 가져오기
  Future<List<dynamic>> fetchFeeds(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/feeds'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        // JSON 데이터를 리스트로 파싱하여 반환
        List<dynamic> feeds = json.decode(utf8.decode(response.bodyBytes));
        return feeds.map((feedData) {
          return {
            'username': feedData['userNickname'],
            'userimg': feedData['userProfileImg'],
            'content': feedData['feedContent'],
            'time': feedData['feedCreateAt'],
            'imageUrl': feedData['feedImage'] != null
                ? '$baseUrl/ftp/image?path=${Uri.encodeComponent(feedData['feedImage'])}'
                : 'https://your-default-image-url.com/default-profile-image.jpg',
            'comments': feedData['comments'] ?? [],
            'feedId': feedData['feedId'],
          };
        }).toList();
      } else {
        throw Exception('피드 가져오기 실패: ${response.statusCode}');
      }
    } catch (e) {
      print('피드 조회 실패: $e');
      throw Exception('피드 조회 실패');
    }
  }

  Future<void> logout(String token) async {
    await http.post(
      Uri.parse('$baseUrl/auth/logout'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
  }

    // 유저정보를 이메일을 통해 가져온다.
  Future<User?> fetchUserProfileByEmail(String token, String email) async {
    final response = await http.get(
      Uri.parse('$baseUrl/user/profile?email=$email'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return User.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('유저 프로필 가져오기 실패: ${response.statusCode}');
    }
  }

}
