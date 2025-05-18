import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdevcamp_workshop/pages/home/providers/cats.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/cat_detail_card.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/cat_tile.dart';

import '../../../../domain/domain.dart';

class CastsTab extends ConsumerWidget {
  const CastsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catsList = ref.watch(catsListProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: switch (catsList) {
        AsyncError() => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Error loading breeds - ${catsList.error}'),
              Text(catsList.stackTrace.toString().substring(30)),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: () => ref.read(catsListProvider.notifier).load(), child: const Text('Retry')),
            ],
          ),
        ),
        AsyncData(:final value) => _CatsList(cats: value),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _CatsList extends StatelessWidget {
  final List<Cat> cats;

  const _CatsList({super.key, required this.cats});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cats.length,
      itemBuilder: (context, index) {
        final cat = cats[index];

        return CatTile(
          cat: cat,
          onTap: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) => CatDetailCard(cat: cat),
            );
          },
        );
      },
    );
  }
}
