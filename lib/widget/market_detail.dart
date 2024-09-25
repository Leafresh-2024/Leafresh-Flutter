import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api_marketService.dart';
import '../models/market.dart';  // MarketDTO 사용
import '../controllers/user_viewmodel.dart';  // UserViewModel 사용

class MarketDetail extends StatelessWidget {
  final MarketDTO market;
  final Function(int) onViewDetail;

  MarketDetail({required this.market, required this.onViewDetail});

  @override
  Widget build(BuildContext context) {
    // 이미지 경로를 FTP API 경로로 변환
    String imageUrl = market.marketImage.isNotEmpty
        ? 'http://10.0.2.2:8080/ftp/image?path=${Uri.encodeComponent(market.marketImage)}'
        : 'https://your-default-image-url.com/default-market-image.jpg'; // 기본 이미지


    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                  radius: 20,
                ),
                const SizedBox(width: 10),
                Text(market.userEmail),  // userNickname 대신 userEmail로 수정
              ],
            ),
            const SizedBox(height: 10),
            market.marketImage.isNotEmpty
                ? Image.network(imageUrl) // FTP 서버 경로로부터 이미지 불러오기
                : const SizedBox.shrink(), // 이미지가 없을 경우 빈 공간 처리
            const SizedBox(height: 10),
            Text(market.marketTitle),
            const SizedBox(height: 10),
            Text(market.marketContent),
            const SizedBox(height: 10),
            Text('등록일자: ${market.marketCreatedAt}'),
            const Divider(),
            ElevatedButton(
              onPressed: () {
                onViewDetail(int.parse(market.marketId));  // marketId는 문자열이므로 int로 변환
              },
              child: const Text('자세히보기'),
            )
          ],
        ),
      ),
    );
  }
}
