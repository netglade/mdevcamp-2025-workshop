import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';

class CatBreedInfo extends StatelessWidget {
  const CatBreedInfo({required this.cat, super.key});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.labelSmall,
        children: [
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(padding: EdgeInsets.only(right: 2), child: FaIcon(FontAwesomeIcons.paw, size: 16)),
          ),
          TextSpan(text: cat.breed.name, style: const TextStyle(color: Colors.brown)),
        ],
      ),
    );
  }
}
