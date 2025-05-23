import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/providers/basket.dart';
import 'package:mdevcamp_workshop/providers/cats_filter.dart';
import 'package:mdevcamp_workshop/providers/cats_list.dart';
import 'package:mdevcamp_workshop/shared/widgets/cat_detail_card.dart';
import 'package:mdevcamp_workshop/shared/widgets/cat_tile.dart';

class CastsTab extends ConsumerWidget {
  const CastsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catsListValue = ref.watch(catsListProvider);
    final filter = ref.watch(catsFilterProvider);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: switch (catsListValue) {
        AsyncError() => Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Error loading breeds - ${catsListValue.error}'),
                Text(catsListValue.stackTrace.toString().substring(30)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.read(catsListProvider.notifier).refresh(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        AsyncData(:final value) =>
          _CatsList(cats: value.where((cat) => !cat.isAdopted && (filter?.apply(cat: cat) ?? true)).toList()),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _CatsList extends ConsumerStatefulWidget {
  final List<Cat> cats;

  const _CatsList({required this.cats});

  @override
  ConsumerState<_CatsList> createState() => _CatsListState();
}

class _CatsListState extends ConsumerState<_CatsList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.cats.length,
      itemBuilder: (context, index) {
        final cat = widget.cats[index];

        return CatTile(
          cat: cat,
          onTap: () {
            showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (context) => CatDetailCard(
                catId: cat.id,
                onAddToBasket: () => ref.read(basketProvider.notifier).addToBasket(cat),
                onRemoveFromBasket: () => ref.read(basketProvider.notifier).removeFromBasket(cat),
              ),
            );
          },
          onAddToBasket: () => ref.read(basketProvider.notifier).addToBasket(cat),
          onRemoveFromBasket: () => ref.read(basketProvider.notifier).removeFromBasket(cat),
        );
      },
    );
  }
}
