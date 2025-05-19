import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            setState(() {
              currentIndex = index;
            });
          }
        },
      ),
    );
  }
}
