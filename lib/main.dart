import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mdevcamp_workshop/di_container.dart';
import 'package:mdevcamp_workshop/pages/account/account_page.dart';
import 'package:mdevcamp_workshop/pages/basket/basket_page.dart';
import 'package:mdevcamp_workshop/pages/home/home_page.dart';

void main() {
  setupDi();

  // WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseRemoteConfig.instance.setConfigSettings(
  //   RemoteConfigSettings(
  //       fetchTimeout: const Duration(seconds: 30),
  //       minimumFetchInterval: const Duration(seconds: 30)),
  // );
  // FirebaseRemoteConfig.instance.setDefaults({
    
  // });

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
