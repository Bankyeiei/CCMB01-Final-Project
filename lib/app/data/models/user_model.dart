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
      email: jsonMap['email'] ?? '',
      name: jsonMap['name'] ?? 'Unknown',
      phone: jsonMap['phone'] ?? '',
      imageUrl: jsonMap['image_url'] ?? '',
      imageId: jsonMap['image_id'] ?? '',
      createdAt: jsonMap['created_at'].toDate(),
    );
  }

  static Map<String, dynamic> toJson(User user) {
    final Map<String, dynamic> userMap = {
      'email': user.email,
      'name': user.name,
      'phone': user.phone,
      'image_url': user.imageUrl,
      'image_id': user.imageId,
      'created_at': user.createdAt,
    };
    return userMap;
  }
}
