import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/cat.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/afraid_of.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/age.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/cat_breed_info.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/favorite_food.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/widgets/price.dart';

class CatDetailCard extends StatelessWidget {
  final Cat cat;

  const CatDetailCard({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 60),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                  Divider(),
                  Text('Origin story'),
                  Card(
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
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
                            padding: const EdgeInsets.only(left: 32, right: 32.0),
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

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
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
                                padding: const EdgeInsets.only(right: 8.0),
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
