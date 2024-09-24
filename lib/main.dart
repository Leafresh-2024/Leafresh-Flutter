import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/user_viewmodel.dart';
import 'views/login_page.dart';
import 'views/profile_page.dart';

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
        home: LoginPage(),
        routes: {
          '/profile': (context) => ProfilePage(),
        },
      ),
    );
  }
}
