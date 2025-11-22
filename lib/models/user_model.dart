class AppUser {
  final String id;
  final String email;
  final String username;
  final String? avatarUrl;
  final String? city;
  final String? politicalPreference;

  AppUser({
    required this.id,
    required this.email,
    required this.username,
    this.avatarUrl,
    this.city,
    this.politicalPreference,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatar_url'] as String?,
      city: json['city'] as String?,
      politicalPreference: json['political_preference'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'avatar_url': avatarUrl,
      'city': city,
      'political_preference': politicalPreference,
    };
  }
}
