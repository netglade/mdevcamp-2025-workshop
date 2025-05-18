import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../domain/domain.dart';

class AfraidOf extends StatelessWidget {
  const AfraidOf({super.key, required this.cat});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(padding: const EdgeInsets.only(right: 8.0), child: FaIcon(FontAwesomeIcons.ghost, size: 16)),
          ),
          TextSpan(text: 'Afraid of: ', style: TextStyle(color: Colors.blueGrey)),
          TextSpan(text: cat.afraidOfThing),
        ],
      ),
    );
  }
}

class FunFact extends StatelessWidget {
  const FunFact({super.key, required this.cat});

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
              child: FaIcon(FontAwesomeIcons.faceLaughWink, size: 16),
            ),
          ),
          TextSpan(text: 'Fun fact: ', style: TextStyle(color: Colors.blueGrey)),
          TextSpan(text: cat.funFact),
        ],
      ),
    );
  }
}
