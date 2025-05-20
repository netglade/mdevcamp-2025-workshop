import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdevcamp_workshop/di_container.dart';
import 'package:mdevcamp_workshop/firebase_options.dart';
import 'package:mdevcamp_workshop/pages/account/account_page.dart';
import 'package:mdevcamp_workshop/pages/basket/basket_page.dart';
import 'package:mdevcamp_workshop/pages/home/home_page.dart';

Future<void> main() async {
  setupDi();

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cats Adopt Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.green)),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/basket': (context) => const BasketPage(),
        '/account': (context) => const AccountPage(),
      },
    );
  }
}
