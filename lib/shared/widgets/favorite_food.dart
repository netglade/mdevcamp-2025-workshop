import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/domain.dart';

class FavoriteFood extends StatelessWidget {
  const FavoriteFood({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: FaIcon(FontAwesomeIcons.utensils, size: 16),
            ),
          ),
          TextSpan(text: 'Favorite food: ', style: TextStyle(color: Colors.blueGrey)),
          TextSpan(text: cat.favoriteFood),
        ],
      ),
    );
  }
}
