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
      userId: json['userId'],
      userName: json['userName'],
      userNickname: json['userNickname'],
      email: json['email'],
      userPhoneNumber: json['userPhoneNumber'],
      role: json['role']['name'],
      imageUrl: json['imageUrl'],
    );
  }
}
