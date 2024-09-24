import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/user_viewmodel.dart';
import '../services/api_service.dart';
import '../widget/community_detail.dart';

class CommunityPage extends StatefulWidget {
  @override
  _CommunityPageState createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<dynamic> feeds = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkLoginStatus();
    });
  }

  void checkLoginStatus() {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    if (userViewModel.token == null) {
      Navigator.pushReplacementNamed(context, '/login'); // 로그인 페이지로 이동
    } else {
      fetchFeeds();
    }
  }

  Future<void> fetchFeeds() async {
    try {
      final token = Provider.of<UserViewModel>(context, listen: false).token;

      if (token == null) {
        throw Exception('토큰이 없습니다. 로그인이 필요합니다.');
      }

      final response = await ApiService().fetchFeeds(token);
      setState(() {
        feeds = response;
        isLoading = false;
      });
    } catch (e) {
      print('피드 조회 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('커뮤니티'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: feeds.length,
        itemBuilder: (context, index) {
          final feed = feeds[index];
          return CommunityDetail(
            feed: feed,
            onAddComment: (comment) {
              // 여기에 댓글 추가 로직을 작성합니다
              print('댓글이 추가되었습니다: $comment');
            },
          );
        },
      ),
    );
  }
}
