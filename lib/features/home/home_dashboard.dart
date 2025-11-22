import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:baguette/core/theme.dart';
import 'package:baguette/services/providers.dart';
import 'package:baguette/widgets/law_card.dart';
import 'package:baguette/widgets/baguette_progress_bar.dart';

class HomeDashboard extends ConsumerWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredLawsAsync = ref.watch(featuredLawsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'La Baguette',
          style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.navy),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(featuredLawsProvider.future),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader('Propositions du moment'),
              featuredLawsAsync.when(
                data: (laws) => Column(
                  children: laws
                      .take(3)
                      .map((law) => LawCard(law: law))
                      .toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(child: Text('Erreur: $err')),
              ),
              const SizedBox(height: 20),
              _buildSectionHeader('Tendances'),
              _buildTrendingVote(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppTheme.navy,
        ),
      ),
    );
  }

  Widget _buildTrendingVote() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
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
            'Loi sur la sécurité numérique',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text('Votes de la communauté'),
          const SizedBox(height: 12),
          const BaguetteProgressBar(
            pourPercent: 60,
            contrePercent: 30,
            abstentionPercent: 10,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLegendItem('Pour', Colors.green.shade400, '60%'),
              _buildLegendItem('Contre', AppTheme.red, '30%'),
              _buildLegendItem('Abs.', Colors.grey.shade400, '10%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color, String value) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text('$label $value', style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
