import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';

class AfraidOf extends StatelessWidget {
  const AfraidOf({required this.cat, super.key});

  final Cat cat;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          const WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(padding: EdgeInsets.only(right: 8), child: FaIcon(FontAwesomeIcons.ghost, size: 16)),
          ),
          const TextSpan(text: 'Afraid of: ', style: TextStyle(color: Colors.blueGrey)),
          TextSpan(text: cat.afraidOfThing),
        ],
      ),
    );
  }
}

class FunFact extends StatelessWidget {
  const FunFact({required this.cat, super.key});

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
              child: FaIcon(FontAwesomeIcons.faceLaughWink, size: 16),
            ),
          ),
          const TextSpan(text: 'Fun fact: ', style: TextStyle(color: Colors.blueGrey)),
          TextSpan(text: cat.funFact),
        ],
      ),
    );
  }
}
