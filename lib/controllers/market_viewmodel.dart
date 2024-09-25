import 'package:flutter/material.dart';
import '../models/market.dart'; // MarketDTO 사용
import '../services/api_marketService.dart'; // MarketService 사용

class MarketViewModel extends ChangeNotifier {
  List<MarketDTO> _markets = [];
  MarketDTO? _selectedMarket;
  bool _isLoading = false;
  final MarketService _marketService = MarketService();
  String? _token;

  // getter를 통해 외부에서 사용할 수 있도록 함
  List<MarketDTO> get markets => _markets;
  MarketDTO? get selectedMarket => _selectedMarket;
  bool get isLoading => _isLoading;

  // 토큰 설정
  void setToken(String token) {
    _token = token;
  }

  // 마켓 리스트 불러오기
  Future<void> fetchMarkets() async {
    if (_token == null) {
      throw Exception('토큰이 없습니다.');
    }
    try {
      _isLoading = true;
      notifyListeners();  // 상태 변화를 알림 (로딩 시작)

      final fetchedMarkets = await _marketService.fetchMarkets(_token!);
      _markets = fetchedMarkets;

      _isLoading = false;
      notifyListeners();  // 상태 변화를 알림 (로딩 완료)
    } catch (e) {
      _isLoading = false;
      print("마켓 정보 조회 에러: $e");
      notifyListeners();
    }
  }

  // 마켓 상세 정보 불러오기
  Future<void> fetchMarketDetail(int marketId) async {
    if (_token == null) {
      throw Exception('토큰이 없습니다.');
    }
    try {
      _isLoading = true;
      notifyListeners();  // 상태 변화를 알림 (로딩 시작)

      final fetchedMarket = await _marketService.fetchMarketDetail(_token!, marketId);
      _selectedMarket = fetchedMarket;

      _isLoading = false;
      notifyListeners();  // 상태 변화를 알림 (로딩 완료)
    } catch (e) {
      _isLoading = false;
      print("마켓 상세 정보 조회 에러: $e");
      notifyListeners();
    }
  }

  // 로그아웃 시 마켓 데이터 초기화
  void clearMarkets() {
    _markets = [];
    _selectedMarket = null;
    _token = null;
    notifyListeners();
  }
}
