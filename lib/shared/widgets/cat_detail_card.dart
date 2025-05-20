import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/providers/basket.dart';
import 'package:mdevcamp_workshop/providers/cats_list.dart';
import 'package:mdevcamp_workshop/shared/widgets/widgets.dart';

class CatDetailCard extends ConsumerWidget {
  final String catId;
  final VoidCallback? onAddToBasket;
  final VoidCallback? onRemoveFromBasket;

  const CatDetailCard({
    required this.catId,
    super.key,
    this.onAddToBasket,
    this.onRemoveFromBasket,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCats = ref.watch(catsListProvider);
    final basket = ref.watch(basketProvider);

    if (allCats.isLoading) return Container();

    if (allCats.hasError) return Container();

    final cat = allCats.value!.firstWhere((x) => x.id == catId);
    final isInBasket = basket.any((c) => c.id == cat.id);

    return Padding(
      padding: const EdgeInsets.only(bottom: 60),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: cat.imageUrl,
                    fit: BoxFit.fitWidth,
                    height: 250,
                    width: double.infinity,
                  ),
                ),
                Positioned(
                  right: 0,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.only(bottomLeft: Radius.circular(16), topRight: Radius.circular(16)),
                      child: Container(
                        width: 48,
                        height: 48,
                        color: Theme.of(context).colorScheme.primary.withAlpha(150),
                        child: Center(
                          child: FaIcon(
                            FontAwesomeIcons.xmark,
                            color: Theme.of(context).colorScheme.onPrimary.withAlpha(160),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(cat.name, style: Theme.of(context).textTheme.titleLarge),
                  Price(cat: cat),
                  CatBreedInfo(cat: cat),
                  Age(cat: cat),
                  FavoriteFood(cat: cat),
                  AfraidOf(cat: cat),
                  FunFact(cat: cat),
                  const Divider(),
                  const Text('Origin story'),
                  Card(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            left: 0,
                            child: Text(
                              '“',
                              style: TextStyle(
                                fontSize: 40,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 32, right: 32),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    cat.originStory,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                                    softWrap: true,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Text(
                              '”',
                              style: TextStyle(
                                fontSize: 40,
                                color: Theme.of(context).colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (isInBasket && onRemoveFromBasket != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onRemoveFromBasket,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Theme.of(context).colorScheme.error,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FaIcon(
                                    FontAwesomeIcons.cartShopping,
                                    color: Theme.of(context).colorScheme.onError,
                                  ),
                                ),
                              ),
                              TextSpan(
                                text: 'Remove from basket',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onError),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  if (!isInBasket && onAddToBasket != null)
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: onAddToBasket,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 8),
                                  child: FaIcon(FontAwesomeIcons.cat, color: Theme.of(context).colorScheme.onPrimary),
                                ),
                              ),
                              TextSpan(
                                text: 'Adopt Me',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
