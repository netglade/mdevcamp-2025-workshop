import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';

class FavoriteFood extends StatelessWidget {
  const FavoriteFood({required this.cat, super.key});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: EdgeInsets.only(right: 8),
              child: FaIcon(FontAwesomeIcons.utensils, size: 16),
            ),
          ),
          const TextSpan(text: 'Favorite food: ', style: TextStyle(color: Colors.blueGrey)),
          TextSpan(text: cat.favoriteFood),
        ],
      ),
    );
  }
}
