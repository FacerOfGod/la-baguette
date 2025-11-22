import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:baguette/models/user_model.dart';
import 'package:baguette/services/auth_service.dart';
import 'package:baguette/services/laws_service.dart';
import 'package:baguette/services/deputies_service.dart';
import 'package:baguette/services/vote_service.dart';

// Services Providers
final authServiceProvider = Provider<AuthService>((ref) => MockAuthService());
final lawsServiceProvider = Provider<LawsService>((ref) => MockLawsService());
final deputiesServiceProvider = Provider<DeputiesService>(
  (ref) => MockDeputiesService(),
);
final voteServiceProvider = Provider<VoteService>((ref) => MockVoteService());

// Auth State
final authStateProvider = StreamProvider<AppUser?>((ref) {
  return ref.watch(authServiceProvider).authStateChanges;
});

final currentUserProvider = Provider<AppUser?>((ref) {
  return ref.watch(authStateProvider).value;
});

// Laws Data
final featuredLawsProvider = FutureProvider((ref) {
  return ref.watch(lawsServiceProvider).getFeaturedLaws();
});

final lawDetailsProvider = FutureProvider.family((ref, String id) {
  return ref.watch(lawsServiceProvider).getLawById(id);
});

// Deputies Data
final deputiesListProvider = FutureProvider((ref) {
  return ref.watch(deputiesServiceProvider).getAllDeputies();
});

final deputyDetailsProvider = FutureProvider.family((ref, String id) {
  return ref.watch(deputiesServiceProvider).getDeputyById(id);
});

// Vote Data
final communityVoteProvider = FutureProvider.family((ref, String lawId) {
  return ref.watch(voteServiceProvider).getCommunityVote(lawId);
});

final userVoteProvider = FutureProvider.family((ref, String lawId) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return null;
  return ref.watch(voteServiceProvider).getUserVote(lawId, user.id);
});
