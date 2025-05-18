import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/pages/home/providers/home_page_bottom_nav_notifier.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/breeds/breeds_tab.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/cats_tab.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(homePageBottomNavNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: switch (currentIndex) {
          0 => const Center(child: Text('Cats')),
          1 => const Center(child: Text('Breeds')),
          2 => const Center(child: Text('Adopted')),
          _ => const Center(child: Text('Unknown')),
        },
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.basketShopping),
            onPressed: () {
              Navigator.pushNamed(context, '/basket');
            },
          ),
        ],
      ),
      body: switch (currentIndex) {
        0 => CastsTab(),
        1 => BreedsTab(),
        2 => const Center(child: Text('Adopted')),
        _ => const Center(child: Text('Unknown')),
      },
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.cat), label: 'Cats'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.paw), label: 'Breeds'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.heart), label: 'Adopted'),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          if (index != currentIndex) {
            ref.read(homePageBottomNavNotifierProvider.notifier).setIndex(index);
          }
        },
      ),
    );
  }
}
