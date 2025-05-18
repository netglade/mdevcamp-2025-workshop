import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/afraid_of.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/age.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/cat_breed_info.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/favorite_food.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/price.dart';

import '../../../../../domain/domain.dart';

class CatTile extends StatelessWidget {
  final Cat cat;
  final VoidCallback? onTap;

  const CatTile({super.key, required this.cat, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // * Image
              ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: cat.imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: FaIcon(FontAwesomeIcons.cat)),
                ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        // * Shop
                        ClipRRect(
                          borderRadius: const BorderRadius.horizontal(left: Radius.circular(16)),
                          child: Container(
                            color: Theme.of(context).colorScheme.primary,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            child: IconButton(
                              onPressed: () {},
                              icon: FaIcon(
                                FontAwesomeIcons.basketShopping,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Price(cat: cat),
                    Age(cat: cat),
                    FavoriteFood(cat: cat),
                    AfraidOf(cat: cat),
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
