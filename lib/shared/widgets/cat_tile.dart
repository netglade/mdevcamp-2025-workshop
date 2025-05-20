import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/providers/basket.dart';
import 'package:mdevcamp_workshop/shared/widgets/afraid_of.dart';
import 'package:mdevcamp_workshop/shared/widgets/age.dart';
import 'package:mdevcamp_workshop/shared/widgets/cat_breed_info.dart';
import 'package:mdevcamp_workshop/shared/widgets/favorite_food.dart';
import 'package:mdevcamp_workshop/shared/widgets/price.dart';

class CatTile extends ConsumerWidget {
  final Cat cat;
  final VoidCallback? onTap;
  final VoidCallback? onAddToBasket;
  final VoidCallback? onRemoveFromBasket;

  const CatTile({required this.cat, super.key, this.onTap, this.onAddToBasket, this.onRemoveFromBasket});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);

    final isInBasket = basket.any((x) => x.id == cat.id);

    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // * Image
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: cat.imageUrl,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: FaIcon(FontAwesomeIcons.cat)),
                    ),
                  ),
                  if (isInBasket)
                    Positioned(
                      bottom: 0,
                      child: Container(
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(16)),
                          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.5),
                        ),
                        child: Center(
                          child: Text(
                            'In basket',
                            style: Theme.of(
                              context,
                            ).textTheme.titleSmall?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(width: 16),
              // * Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 8,
                  children: [
                    Row(
                      spacing: 4,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // * Name and Breed
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cat.name, style: Theme.of(context).textTheme.titleMedium),
                            CatBreedInfo(cat: cat),
                          ],
                        ),
                        // * Add to basket
                        if (!isInBasket && onAddToBasket != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                            child: Container(
                              color: Theme.of(context).colorScheme.primary,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: IconButton(
                                onPressed: onAddToBasket,
                                icon: FaIcon(
                                  FontAwesomeIcons.basketShopping,
                                  color: Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ),
                          ),
                        if (isInBasket && onRemoveFromBasket != null)
                          ClipRRect(
                            borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                            child: Container(
                              color: Theme.of(context).colorScheme.error,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: IconButton(
                                onPressed: onRemoveFromBasket,
                                icon: FaIcon(FontAwesomeIcons.trashCan, color: Theme.of(context).colorScheme.onError),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Price(cat: cat), Age(cat: cat), FavoriteFood(cat: cat), AfraidOf(cat: cat)],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
