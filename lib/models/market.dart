class MarketDTO {
  final int marketId;
  final String marketCategory;
  final String marketTitle;
  final String marketContent;
  final String marketImage;
  final bool marketStatus;
  final String marketVisibleScope;
  final String marketCreatedAt;
  final String userEmail;

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
      marketId: json['marketId'],
      marketCategory: json['marketCategory'],
      marketTitle: json['marketTitle'],
      marketContent: json['marketContent'],
      marketImage: json['marketImage'],
      marketStatus: json['marketStatus'],
      marketVisibleScope: json['marketVisibleScope'],
      marketCreatedAt: json['marketCreatedAt'],
      userEmail: json['userEmail'],
    );
  }
}
