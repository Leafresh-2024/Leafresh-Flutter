import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_marketService.dart'; // MarketService 사용
import '../models/market.dart'; // MarketDTO 사용
import '../controllers/user_viewmodel.dart'; // UserViewModel 사용

class MarketDetailPage extends StatefulWidget {
  final int marketId;

  const MarketDetailPage({required this.marketId, super.key});

  @override
  _MarketDetailPageState createState() => _MarketDetailPageState();
}
class _MarketDetailPageState extends State<MarketDetailPage> {
  late MarketDTO market;
  bool isLoading = true;
  String? userPhoneNumber;
  String? userName;
  String? userProfileImageUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchMarketDetail();
    });
  }

  // 마켓 상세 정보를 불러오는 함수
  Future<void> fetchMarketDetail() async {
    try {
      final token = Provider.of<UserViewModel>(context, listen: false).token;

      if (token == null) {
        throw Exception('토큰이 없습니다. 로그인이 필요합니다.');
      }

      // 마켓 상세 정보 가져오기
      final marketDetail = await MarketService().fetchMarketDetail(token, widget.marketId);
      setState(() {
        market = marketDetail;
        isLoading = false;
      });

      // 유저 전화번호, 이름, 프로필 사진 가져오기
      await fetchUserDetails(market.userEmail);
    } catch (e) {
      print('마켓 상세 정보 조회 실패: $e');
    }
  }

  // 사용자 정보 가져오기
  Future<void> fetchUserDetails(String email) async {
    try {
      print(email);
      await Provider.of<UserViewModel>(context, listen: false).fetchUserByEmail(email);
      final user = Provider.of<UserViewModel>(context, listen: false).user;

      setState(() {
        userPhoneNumber = user?.userPhoneNumber ?? '전화번호 없음';
        userName = user?.userName ?? '이름 없음';
        userProfileImageUrl = user?.imageUrl ?? 'https://your-default-image-url.com/default-profile-image.jpg';
      });
    } catch (e) {
      print('유저 정보 조회 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마켓 상세보기'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // 로딩 중일 때
          : Padding(
        padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 마켓 이미지
                Image.network(
                  market.marketImage.isNotEmpty
                      ? 'http://10.0.2.2:8080/ftp/image?path=${Uri.encodeComponent(market.marketImage)}'
                      : 'https://your-default-image-url.com/default-image.jpg',
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                // 게시자 프로필 이미지
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        userProfileImageUrl ??
                            'https://your-default-image-url.com/default-profile-image.jpg',
                      ),
                      radius: 30,
                    ),
                    const SizedBox(width: 10),
                    // 게시자 이름과 이메일
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName ?? '이름 없음',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text('이메일: ${market.userEmail}'),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // 마켓 제목
                Text(
                  market.marketTitle,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                // 마켓 내용
                Text(market.marketContent),
                const SizedBox(height: 10),
                // 게시일자
                Text('게시일자: ${market.marketCreatedAt}'),
                const SizedBox(height: 10),
                // 전화번호 표시
                Text('전화번호: ${userPhoneNumber ?? '조회 중...'}'),

            ],
          ),
        ),
      );
    }
}