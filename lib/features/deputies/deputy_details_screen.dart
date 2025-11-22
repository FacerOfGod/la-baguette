import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:baguette/core/theme.dart';
import 'package:baguette/services/providers.dart';

class DeputyDetailsScreen extends ConsumerWidget {
  final String deputyId;

  const DeputyDetailsScreen({super.key, required this.deputyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deputyAsync = ref.watch(deputyDetailsProvider(deputyId));

    return Scaffold(
      appBar: AppBar(title: const Text('Détails Député')),
      body: deputyAsync.when(
        data: (deputy) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(deputy.photoUrl),
                backgroundColor: AppTheme.lightGrey,
              ),
              const SizedBox(height: 16),
              Text(
                deputy.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.navy,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                deputy.group,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              Text(deputy.region, style: TextStyle(color: Colors.grey[600])),
              const SizedBox(height: 24),
              _buildStatCard(
                'Cohésion Groupe',
                '${(deputy.cohesionScore * 100).toInt()}%',
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Biographie',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                deputy.bio,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_active_outlined),
                  label: const Text('Suivre ce député'),
                ),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppTheme.navy,
            ),
          ),
          const SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }
}
