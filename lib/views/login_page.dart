import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_viewmodel.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('로그인'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: '이메일'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Provider.of<UserViewModel>(context, listen: false).login(
                  emailController.text,
                  passwordController.text,
                  context, // 로그인 후 페이지 이동을 위해 context 전달
                );
              },
              child: Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
