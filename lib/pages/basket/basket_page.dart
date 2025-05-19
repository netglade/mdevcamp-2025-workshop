import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdevcamp_workshop/providers/basket.dart';

import '../../domain/domain.dart';
import '../../shared/shared.dart';

class BasketPage extends ConsumerWidget {
  const BasketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    final cats = basket.toList();

    return Scaffold(
        appBar: AppBar(title: const Text('Basket')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: _BasketList(cats: cats),
        ));
  }
}

class _BasketList extends ConsumerWidget {
  final List<Cat> cats;

  const _BasketList({super.key, required this.cats});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverList.builder(
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
                  builder: (context) => CatDetailCard(catId: cat.id),
                );
              },
              onRemoveFromBasket: () => ref.read(basketProvider.notifier).removeFromBasket(cat),
            );
          },
        ),
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            alignment: Alignment.bottomCenter,
            margin: const EdgeInsets.only(top: 16, bottom: 16),
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                ref.read(basketProvider.notifier).confirmBuy();

                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text('Confirm buy'),
            ),
          ),
        )
      ],
    );
  }
}
