import 'package:flutter/material.dart';
import 'package:leafresh/controllers/user_viewmodel.dart';
import 'package:leafresh/models/market.dart';
import 'package:leafresh/services/api_marketService.dart';
import 'package:provider/provider.dart';
import '../controllers/market_viewmodel.dart';
import '../widget/market_detail.dart';
import 'marketdetail_page.dart'; // MarketViewModel 사용

class MarketPage extends StatefulWidget {
  const MarketPage({super.key});

  @override
  _MarketPageState createState() => _MarketPageState();
}

class _MarketPageState extends State<MarketPage> {
  List<dynamic> markets = [];
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
      fetchMarkets();
    }
  }

  // 마켓 데이터 불러오기
  Future<void> fetchMarkets() async {
    final token = Provider.of<UserViewModel>(context, listen: false).token;

    try {
      if (token == null) {
        throw Exception('토큰이 없습니다. 로그인이 필요합니다.');
      }

      final response = await MarketService().fetchMarkets(token);
      setState(() {
        markets = response;
        isLoading = false; // 로딩 완료 시 false로 설정
      });
    } catch (e) {
      print('마켓 정보 조회 실패: $e');
      setState(() {
        isLoading = false; // 에러 발생 시에도 로딩을 멈춤
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('마켓 목록'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
            itemCount: markets.length,
            itemBuilder: (context, index) {
              final market = markets[index] as MarketDTO;

              return MarketDetail(
                market: market,
                onViewDetail: (marketId) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                  builder: (context) => MarketDetailPage(marketId: marketId),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
