class User {
  final String uid;
  final String email;
  final String username;
  final String phone;
  final String? imageUrl;
  User({
    required this.uid,
    required this.email,
    required this.username,
    required this.phone,
    this.imageUrl,
  });
}
