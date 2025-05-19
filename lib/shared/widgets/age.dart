import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/domain.dart';

class Age extends StatelessWidget {
  const Age({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(padding: const EdgeInsets.only(right: 8.0), child: FaIcon(FontAwesomeIcons.heart, size: 16)),
          ),
          TextSpan(text: '${cat.age} years'),
        ],
      ),
    );
  }
}
