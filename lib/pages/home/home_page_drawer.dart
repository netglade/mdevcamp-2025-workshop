import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).colorScheme.primaryContainer),
            padding: EdgeInsets.zero,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final height = constraints.maxHeight;

                return Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: 'https://cataas.com/cat?width=$width&height=$height',
                      width: width,
                      height: height,
                      fit: BoxFit.cover,
                    ),
                    BackdropFilter(
                      blendMode: BlendMode.srcIn,
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Center(
                        child: Text(
                          'Cats Adopt Demo',
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // TODO(firebase): Add brief info about logged in user

          ListTile(
            leading: const FaIcon(FontAwesomeIcons.user),
            title: const Text('Account'),
            onTap: () {
              Navigator.pushNamed(context, '/account');
            },
          ),
        ],
      ),
    );
  }
}
