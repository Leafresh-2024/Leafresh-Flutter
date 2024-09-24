import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/market.dart';


class MarketService {

  static const String baseUrl = 'http://10.0.2.2:8080';

  // 모든 마켓의 데이터를 가져오는 메서드
  Future<List<MarketDTO>> fetchMarkets(String token) async {
    final response = await http.get(

      Uri.parse('$baseUrl/market'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      List<dynamic> marketJsonList = json.decode(utf8.decode(response.bodyBytes));
      return marketJsonList.map((json) => MarketDTO.fromJson(json)).toList();
    }else{
      throw Exception('마켓 정보 가져오기 실패: ${response.statusCode}');
    }
  }

  // 마켓 상세정보를 가져오는 메서드
  Future<MarketDTO> fetchMarketDetail(String token, int marketId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/market/detail/$marketId'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return MarketDTO.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('마켓 상세 정보 가져오기 실패: ${response.statusCode}');
    }
  }

  }



}