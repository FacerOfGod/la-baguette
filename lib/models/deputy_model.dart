class Deputy {
  final String id;
  final String name;
  final String group;
  final String region;
  final String photoUrl;
  final String bio;
  final double cohesionScore;

  Deputy({
    required this.id,
    required this.name,
    required this.group,
    required this.region,
    required this.photoUrl,
    required this.bio,
    required this.cohesionScore,
  });

  factory Deputy.fromJson(Map<String, dynamic> json) {
    return Deputy(
      id: json['id'] as String,
      name: json['name'] as String,
      group: json['group'] as String,
      region: json['region'] as String,
      photoUrl: json['photo_url'] as String,
      bio: json['bio'] as String,
      cohesionScore: (json['cohesion_score'] as num).toDouble(),
    );
  }
}
