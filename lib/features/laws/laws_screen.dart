import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:baguette/core/theme.dart';
import 'package:baguette/services/providers.dart';
import 'package:baguette/widgets/law_card.dart';

class LawsScreen extends ConsumerWidget {
  const LawsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lawsAsync = ref.watch(featuredLawsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Propositions de loi')),
      body: lawsAsync.when(
        data: (laws) => ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: laws.length,
          itemBuilder: (context, index) => LawCard(law: laws[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
    );
  }
}
