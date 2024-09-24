import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_viewmodel.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);

    if (!userViewModel.isLoggedIn) {
      return const Center(
        child: Text('로그인이 필요합니다.'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              userViewModel.logout('accessToken' as BuildContext);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                userViewModel.user?.imageUrl != null &&
                    userViewModel.user!.imageUrl.startsWith('http')
                    ? userViewModel.user!.imageUrl
                    : 'https://your-default-image-url.com', // 기본 이미지 URL
              ),
              radius: 40,
            ),
            const SizedBox(height: 20),
            Text('닉네임: ${userViewModel.user?.userNickname}'),
            Text('이메일: ${userViewModel.user?.email}'),
          ],
        ),
      ),
    );
  }
}
