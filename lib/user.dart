class User {
  final String name;
  final String phoneNumber;
  final String avatar;
  final double rate;
  final int likes;
  final List<String> photos;
  final int friends;
  final int subs;
  final String? status;

  User({
    required this.name,
    required this.phoneNumber,
    required this.avatar,
    required this.rate,
    required this.likes,
    required this.photos,
    required this.friends,
    required this.subs,
    this.status,
  });
}
