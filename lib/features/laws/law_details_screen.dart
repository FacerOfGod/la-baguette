import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:baguette/core/theme.dart';
import 'package:baguette/services/providers.dart';
import 'package:baguette/models/vote_model.dart';
import 'package:baguette/widgets/baguette_progress_bar.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LawDetailsScreen extends ConsumerWidget {
  final String lawId;

  const LawDetailsScreen({super.key, required this.lawId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lawAsync = ref.watch(lawDetailsProvider(lawId));
    final communityVoteAsync = ref.watch(communityVoteProvider(lawId));
    final userVoteAsync = ref.watch(userVoteProvider(lawId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails'),
        actions: [
          IconButton(icon: const Icon(Icons.share), onPressed: () {}),
          IconButton(icon: const Icon(Icons.bookmark_border), onPressed: () {}),
        ],
      ),
      body: lawAsync.when(
        data: (law) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.navy.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  law.status.toUpperCase(),
                  style: const TextStyle(
                    color: AppTheme.navy,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                law.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.navy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Déposé le ${DateFormat('dd MMMM yyyy', 'fr_FR').format(law.createdAt)}',
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              _buildAuthorSection(law.authors, law.group),
              const SizedBox(height: 24),
              const Text(
                'Résumé',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                law.summary,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 24),
              const Text(
                'Description',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                law.description,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 32),
              _buildVotingSection(ref, communityVoteAsync, userVoteAsync),
              const SizedBox(height: 32),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
    );
  }

  Widget _buildAuthorSection(List<String> authors, String group) {
    return Row(
      children: [
        const CircleAvatar(
          backgroundColor: AppTheme.lightGrey,
          child: Icon(Icons.person, color: Colors.grey),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              authors.join(', '),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(group, style: TextStyle(color: Colors.grey[600])),
          ],
        ),
      ],
    );
  }

  Widget _buildVotingSection(
    WidgetRef ref,
    AsyncValue<CommunityVote> communityVoteAsync,
    AsyncValue<Vote?> userVoteAsync,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Vote de la communauté',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          communityVoteAsync.when(
            data: (stats) => Column(
              children: [
                BaguetteProgressBar(
                  pourPercent: stats.pourPercent,
                  contrePercent: stats.contrePercent,
                  abstentionPercent: stats.abstentionPercent,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Pour', stats.pourPercent, Colors.green),
                    _buildStatItem('Contre', stats.contrePercent, AppTheme.red),
                    _buildStatItem(
                      'Abst.',
                      stats.abstentionPercent,
                      Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  '${stats.total} votes',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            ),
            loading: () => const LinearProgressIndicator(),
            error: (e, s) => const Text('Erreur chargement stats'),
          ),
          const SizedBox(height: 24),
          const Divider(),
          const SizedBox(height: 16),
          const Text(
            'Votre vote',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          userVoteAsync.when(
            data: (userVote) {
              if (userVote != null) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: _getVoteColor(userVote.type).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: _getVoteColor(userVote.type)),
                    ),
                    child: Text(
                      'Vous avez voté ${_getVoteLabel(userVote.type)}',
                      style: TextStyle(
                        color: _getVoteColor(userVote.type),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              }
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildVoteButton(ref, VoteType.pour, 'Pour', Colors.green),
                  _buildVoteButton(
                    ref,
                    VoteType.contre,
                    'Contre',
                    AppTheme.red,
                  ),
                  _buildVoteButton(
                    ref,
                    VoteType.abstention,
                    'Abst.',
                    Colors.grey,
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => const Text('Erreur chargement vote utilisateur'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, double percent, Color color) {
    return Column(
      children: [
        Text(
          '${percent.toInt()}%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: color,
          ),
        ),
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
      ],
    );
  }

  Widget _buildVoteButton(
    WidgetRef ref,
    VoteType type,
    String label,
    Color color,
  ) {
    return ElevatedButton(
      onPressed: () {
        ref.read(voteServiceProvider).castVote(lawId, 'current_user', type);
        // In a real app, we would invalidate providers here to refresh UI
        ref.invalidate(communityVoteProvider(lawId));
        ref.invalidate(userVoteProvider(lawId));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      child: Text(label),
    );
  }

  Color _getVoteColor(VoteType type) {
    switch (type) {
      case VoteType.pour:
        return Colors.green;
      case VoteType.contre:
        return AppTheme.red;
      case VoteType.abstention:
        return Colors.grey;
    }
  }

  String _getVoteLabel(VoteType type) {
    switch (type) {
      case VoteType.pour:
        return 'POUR';
      case VoteType.contre:
        return 'CONTRE';
      case VoteType.abstention:
        return 'ABSTENTION';
    }
  }
}
