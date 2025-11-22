import 'package:flutter/material.dart';
import 'package:baguette/models/deputy_model.dart';
import 'package:baguette/core/theme.dart';
import 'package:go_router/go_router.dart';

class DeputyCard extends StatelessWidget {
  final Deputy deputy;

  const DeputyCard({super.key, required this.deputy});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => context.push('/deputy/${deputy.id}'),
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(deputy.photoUrl),
                backgroundColor: AppTheme.lightGrey,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      deputy.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.navy,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      deputy.group,
                      style: TextStyle(color: Colors.grey[700], fontSize: 14),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      deputy.region,
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const Text(
                    'Cohésion',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  Text(
                    '${(deputy.cohesionScore * 100).toInt()}%',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.navy,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
