class Law {
  final String id;
  final String title;
  final String summary;
  final String description;
  final List<String> authors;
  final String group;
  final String status; // 'commission', 'seance', 'adopted', 'rejected'
  final DateTime createdAt;
  final String sourceUrl;

  Law({
    required this.id,
    required this.title,
    required this.summary,
    required this.description,
    required this.authors,
    required this.group,
    required this.status,
    required this.createdAt,
    required this.sourceUrl,
  });

  factory Law.fromJson(Map<String, dynamic> json) {
    return Law(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      description: json['description'] as String,
      authors: List<String>.from(json['authors'] ?? []),
      group: json['group'] as String,
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      sourceUrl: json['source_url'] as String,
    );
  }
}
