import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/breeds/widgets/origin.dart';

class LifeSpan extends StatelessWidget {
  final String lifeSpan;

  const LifeSpan({super.key, required this.lifeSpan});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FaIcon(FontAwesomeIcons.starOfLife),
        const SizedBox(width: 8),
        Text.rich(
          TextSpan(
            children: [
              TextSpan(text: 'Life span'),
              TextSpan(text: ' $lifeSpan', style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
