import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/breeds/widgets/life_span.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/breeds/widgets/origin.dart';

class BreedDetailCard extends StatelessWidget {
  final CatBreed breed;

  const BreedDetailCard({super.key, required this.breed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8,
          children: [
            if (breed.referenceImageUrl case final image?)
              CachedNetworkImage(imageUrl: image, fit: BoxFit.fitHeight, height: 300, width: double.infinity),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 8,
                children: [
                  Text(breed.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(breed.description),
                  BreedOrigin(origin: breed.origin),
                  LifeSpan(lifeSpan: breed.lifeSpan),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const FaIcon(FontAwesomeIcons.paw),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Temperament', style: const TextStyle(decoration: TextDecoration.underline)),
                            Text(breed.temperament, maxLines: 2, overflow: TextOverflow.ellipsis, softWrap: true),
                          ],
                        ),
                      ),
                    ],
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
