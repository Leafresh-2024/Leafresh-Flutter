class MarketDTO {
  final String marketId;
  final String marketCategory;
  final String marketTitle;
  final String marketContent;
  final String marketImage;
  final String marketStatus;
  final String marketVisibleScope;
  final String marketCreatedAt;
  final String userEmail; // userID 바꾸자

  MarketDTO({
    required this.marketId,
    required this.marketCategory,
    required this.marketTitle,
    required this.marketContent,
    required this.marketImage,
    required this.marketStatus,
    required this.marketVisibleScope,
    required this.marketCreatedAt,
    required this.userEmail,
  });

  factory MarketDTO.fromJson(Map<String, dynamic> json) {
    return MarketDTO(
      marketId: json['marketId']?.toString() ?? '',  // Null일 경우 빈 문자열
      marketCategory: json['marketCategory'] ?? 'Unknown Category',  // 기본값 설정
      marketTitle: json['marketTitle'] ?? 'No Title',
      marketContent: json['marketContent'] ?? 'No Content',
      marketImage: json['marketImage'] ?? 'https://default-image-url.com',
      marketStatus: json['marketStatus']?.toString() ?? 'Unknown',
      marketVisibleScope: json['marketVisibleScope'] ?? 'Public',
      marketCreatedAt: json['marketCreatedAt'] ?? 'Unknown Date',
      userEmail: json['userEmail'] ?? 'No Email',
    );
  }

}
