class User {
  final String userId;
  final String userName;
  final String userNickname;
  final String email;
  final String userPhoneNumber;
  final String role;
  final String imageUrl;

  User({
    required this.userId,
    required this.userName,
    required this.userNickname,
    required this.email,
    required this.userPhoneNumber,
    required this.role,
    required this.imageUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'].toString(), // int 값을 String으로 변환
      userName: json['userName'],
      userNickname: json['userNickname'],
      email: json['email'],
      userPhoneNumber: json['userPhoneNumber'].toString(), // 마찬가지로 변환
      role: json['role']['name'],
      imageUrl: json['imageUrl'] ?? 'default-image-url', // 이미지 URL이 없을 경우 기본값 추가
    );
  }
}
