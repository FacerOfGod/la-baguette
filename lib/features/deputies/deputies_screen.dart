import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:baguette/services/providers.dart';
import 'package:baguette/widgets/deputy_card.dart';

class DeputiesScreen extends ConsumerWidget {
  const DeputiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deputiesAsync = ref.watch(deputiesListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nos Députés')),
      body: deputiesAsync.when(
        data: (deputies) => ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: deputies.length,
          itemBuilder: (context, index) => DeputyCard(deputy: deputies[index]),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
    );
  }
}
