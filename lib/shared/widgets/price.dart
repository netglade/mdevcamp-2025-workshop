import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';

class Price extends StatelessWidget {
  const Price({required this.cat, super.key});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          const TextSpan(text: 'Price: '),
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: EdgeInsets.only(right: 2),
              child: FaIcon(FontAwesomeIcons.dollarSign, size: 16),
            ),
          ),
          TextSpan(text: cat.price.toString(), style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }
}
