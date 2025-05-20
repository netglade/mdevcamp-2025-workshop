import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/providers/basket.dart';
import 'package:mdevcamp_workshop/shared/shared.dart';

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
      ),
    );
  }
}

class _BasketList extends ConsumerWidget {
  final List<Cat> cats;

  const _BasketList({required this.cats});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final isLoggedIn = user != null;

    if (cats.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            Text(
              'No cats in basket yet',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FaIcon(
              FontAwesomeIcons.faceSadCry,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
          ],
        ),
      );
    }

    return CustomScrollView(
      slivers: [
        SliverList.builder(
          itemCount: cats.length,
          itemBuilder: (context, index) {
            final cat = cats[index];

            return CatTile(
              cat: cat,
              onTap: () {
                showModalBottomSheet<void>(
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
        if (!isLoggedIn)
          SliverToBoxAdapter(
            child: Center(
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withAlpha(50),
                  borderRadius: BorderRadius.circular(16),
                ),
                margin: const EdgeInsets.only(top: 16),
                child: Center(
                  child: Text(
                    'You need to be logged in to adopt cats',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ),
            ),
          ),
        if (cats.isNotEmpty && isLoggedIn)
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
                child: const Text('Confirm adoption'),
              ),
            ),
          ),
      ],
    );
  }
}
