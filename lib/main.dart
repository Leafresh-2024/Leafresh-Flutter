import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/user_viewmodel.dart';
import 'views/login_page.dart';
import 'views/community_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(),
      child: MaterialApp(
        title: 'User Profile App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login', // 첫 페이지를 로그인 페이지로 설정
        routes: {
          '/login': (context) => LoginPage(),
          '/community': (context) => CommunityPage(),
        },
      ),
    );
  }
}
