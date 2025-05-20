import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';

class Age extends StatelessWidget {
  const Age({required this.cat, super.key});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(padding: EdgeInsets.only(right: 8), child: FaIcon(FontAwesomeIcons.heart, size: 16)),
          ),
          TextSpan(text: '${cat.age} years'),
        ],
      ),
    );
  }
}
