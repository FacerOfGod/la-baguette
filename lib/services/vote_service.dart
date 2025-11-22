import 'package:baguette/models/vote_model.dart';

abstract class VoteService {
  Future<void> castVote(String lawId, String userId, VoteType type);
  Future<Vote?> getUserVote(String lawId, String userId);
  Future<CommunityVote> getCommunityVote(String lawId);
}

class MockVoteService implements VoteService {
  final Map<String, Vote> _userVotes = {};
  final Map<String, CommunityVote> _communityVotes = {};

  @override
  Future<void> castVote(String lawId, String userId, VoteType type) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _userVotes['${lawId}_$userId'] = Vote(
      lawId: lawId,
      userId: userId,
      type: type,
      timestamp: DateTime.now(),
    );

    // Update mock community stats
    final current =
        _communityVotes[lawId] ??
        CommunityVote(
          lawId: lawId,
          pourCount: 10,
          contreCount: 5,
          abstentionCount: 2,
        );
    _communityVotes[lawId] = CommunityVote(
      lawId: lawId,
      pourCount: current.pourCount + (type == VoteType.pour ? 1 : 0),
      contreCount: current.contreCount + (type == VoteType.contre ? 1 : 0),
      abstentionCount:
          current.abstentionCount + (type == VoteType.abstention ? 1 : 0),
    );
  }

  @override
  Future<Vote?> getUserVote(String lawId, String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _userVotes['${lawId}_$userId'];
  }

  @override
  Future<CommunityVote> getCommunityVote(String lawId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _communityVotes[lawId] ??
        CommunityVote(
          lawId: lawId,
          pourCount: 45,
          contreCount: 30,
          abstentionCount: 12,
        );
  }
}
