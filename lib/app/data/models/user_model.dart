class User {
  final String email;
  String name;
  String phone;
  String imageUrl;
  String imageId;
  final DateTime? createdAt;
  User({
    this.email = '',
    this.name = '',
    this.phone = '',
    this.imageUrl = '',
    this.imageId = '',
    this.createdAt,
  });

  factory User.fromJson(Map<String, dynamic> jsonMap) {
    return User(
      email: jsonMap['email'] ?? 'Unknown',
      name: jsonMap['name'] ?? '',
      phone: jsonMap['phone'] ?? '',
      imageUrl: jsonMap['imageUrl'] ?? '',
      imageId: jsonMap['imageId'] ?? '',
      createdAt: jsonMap['createdAt'],
    );
  }
  static Map<String, dynamic> toJson(User user) {
    Map<String, dynamic> userMap = {
      'email': user.email,
      'name': user.name,
      'phone': user.phone,
      'imageUrl': user.imageUrl,
      'imageId': user.imageId,
      'created_at': user.createdAt,
    };
    return userMap;
  }
}
