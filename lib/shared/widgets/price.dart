import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../domain/domain.dart';

class Price extends StatelessWidget {
  const Price({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(text: 'Price: '),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.only(right: 2.0),
              child: FaIcon(FontAwesomeIcons.dollarSign, size: 16),
            ),
          ),
          TextSpan(text: cat.price.toString(), style: TextStyle(color: Theme.of(context).colorScheme.primary)),
        ],
      ),
    );
  }
}
