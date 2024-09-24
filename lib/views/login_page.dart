import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_viewmodel.dart';
import '../services/api_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final ApiService apiService = ApiService();

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
              onPressed: () async {
                try {
                  final response = await apiService.login(
                    emailController.text,
                    passwordController.text,
                  );

                  if (response != null){
                    //성공적으로 로그인한 경우
                    print('로그인 성공 : ${response['accessToken']}');
                    //로그인 후 다른 페이지로 이동하거나 상태를 업데이트 할 수 있습니다.
                    Provider.of<UserViewModel>(context, listen: false)
                        .fetchUserProfile(response['accessToken']);
                  }
                }catch (e) {
                  print('로그인 에러 : $e');
                }
              },
              child: Text('로그인'),
            ),
          ],
        ),
      ),
    );
  }
}
