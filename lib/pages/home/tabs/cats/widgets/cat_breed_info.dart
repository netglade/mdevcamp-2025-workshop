import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../domain/domain.dart';

class CatBreedInfo extends StatelessWidget {
  const CatBreedInfo({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelSmall,
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(padding: const EdgeInsets.only(right: 2.0), child: FaIcon(FontAwesomeIcons.paw, size: 16)),
          ),
          TextSpan(text: cat.breed.name, style: TextStyle(color: Colors.brown)),
        ],
      ),
    );
  }
}
