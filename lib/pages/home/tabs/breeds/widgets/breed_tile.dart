import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/breeds/widgets/life_span.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/breeds/widgets/origin.dart';

class BreedTile extends StatelessWidget {
  final CatBreed breed;
  final VoidCallback? onTap;

  const BreedTile({super.key, required this.breed, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Column(
          children: [
            Row(
              children: [
                if (breed.referenceImageUrl case final image?)
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Center(child: FaIcon(FontAwesomeIcons.cat)),
                    ),
                  ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(breed.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(breed.description, overflow: TextOverflow.ellipsis, maxLines: 4, softWrap: true),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [BreedOrigin(origin: breed.origin), LifeSpan(lifeSpan: breed.lifeSpan)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
