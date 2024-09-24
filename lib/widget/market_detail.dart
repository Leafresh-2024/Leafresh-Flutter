import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_marketService.dart';
import '../models/market.dart';  // MarketDTO 사용
import '../controllers/user_viewmodel.dart';  // UserViewModel 사용

class MarketDetailPage extends StatefulWidget {
  final int marketId;

  const MarketDetailPage({required this.marketId, super.key});

  @override
  _MarketDetailPageState createState() => _MarketDetailPageState();
}

class _MarketDetailPageState extends State<MarketDetailPage> {
  late MarketDTO market;
  bool isLoading = true;

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

      final marketDetail = await MarketService().fetchMarketDetail(token, widget.marketId);
      setState(() {
        market = marketDetail;
        isLoading = false;
      });
    } catch (e) {
      print('마켓 상세 정보 조회 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마켓 상세보기'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())  // 로딩 중일 때
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              market.marketImage.isNotEmpty
                  ? market.marketImage
                  : 'https://your-default-image-url.com/default-image.jpg',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text(
              market.marketTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(market.marketContent),
            const SizedBox(height: 10),
            Text('게시일자: ${market.marketCreatedAt}'),
            const SizedBox(height: 10),
            Text('게시자 이메일: ${market.userEmail}'),
          ],
        ),
      ),
    );
  }
}
