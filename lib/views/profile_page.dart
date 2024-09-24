import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_viewmodel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});  // const 키워드 추가


  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    if (!userViewModel.isLoggedIn) {
      return Center(
        child: Text('로그인이 필요합니다.'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),  // const 추가
            onPressed: () {
              userViewModel.logout('accessToken');
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(userViewModel.user?.imageUrl ?? ''),
              radius: 40,
            ),
            SizedBox(height: 20),
            Text('닉네임: ${userViewModel.user?.userNickname}'),
            Text('이메일: ${userViewModel.user?.email}'),
          ],
        ),
      ),
    );
  }
}
