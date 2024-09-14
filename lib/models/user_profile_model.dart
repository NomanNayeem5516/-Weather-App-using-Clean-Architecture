class UserProfile {
  final int id;
  final String email;
  final String name;
  final String role;
  final String avatar;

  UserProfile({
    required this.id,
    required this.email,
    required this.name,
    required this.role,
    required this.avatar,
  });

  // Factory method to create UserProfile from JSON
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      role: json['role'],
      avatar: json['avatar'],
    );
  }
}
