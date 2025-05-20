import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mdevcamp_workshop/pages/home/filter_cats_button.dart';
import 'package:mdevcamp_workshop/pages/home/home_page_drawer.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/adopted/adopted_cats_tab.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/breeds/breeds_tab.dart';
import 'package:mdevcamp_workshop/pages/home/tabs/cats/cats_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: switch (currentIndex) {
          0 => const Text('Cats'),
          1 => const Text('Breeds'),
          2 => const Text('Adopted'),
          _ => const Text('Unknown'),
        },
        actions: [
          if (currentIndex == 0) const FilterCatsButton(),

          // TODO(introduction): Add badge with number of items in basket.
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.basketShopping),
            onPressed: () {
              Navigator.pushNamed(context, '/basket');
            },
          ),
        ],
      ),
      body: switch (currentIndex) {
        0 => const CastsTab(),
        1 => const BreedsTab(),
        2 => const AdoptedCatsTab(),
        _ => const Center(child: Text('Unknown')),
      },
      drawer: const HomePageDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.cat), label: 'Cats'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.paw), label: 'Breeds'),
          BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.heart), label: 'Adopted'),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          if (index != currentIndex) {
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
