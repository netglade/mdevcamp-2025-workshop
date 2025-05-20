import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BreedOrigin extends StatelessWidget {
  final String origin;

  const BreedOrigin({required this.origin, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(children: [const FaIcon(FontAwesomeIcons.globe), const SizedBox(width: 8), Text(origin)]);
  }
}
