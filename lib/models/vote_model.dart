enum VoteType { pour, contre, abstention }

class Vote {
  final String lawId;
  final String userId;
  final VoteType type;
  final DateTime timestamp;

  Vote({
    required this.lawId,
    required this.userId,
    required this.type,
    required this.timestamp,
  });

  factory Vote.fromJson(Map<String, dynamic> json) {
    return Vote(
      lawId: json['law_id'] as String,
      userId: json['user_id'] as String,
      type: VoteType.values.firstWhere((e) => e.name == json['type']),
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }
}

class CommunityVote {
  final String lawId;
  final int pourCount;
  final int contreCount;
  final int abstentionCount;

  CommunityVote({
    required this.lawId,
    required this.pourCount,
    required this.contreCount,
    required this.abstentionCount,
  });

  int get total => pourCount + contreCount + abstentionCount;

  double get pourPercent => total == 0 ? 0 : (pourCount / total) * 100;
  double get contrePercent => total == 0 ? 0 : (contreCount / total) * 100;
  double get abstentionPercent =>
      total == 0 ? 0 : (abstentionCount / total) * 100;
}
