import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:mdevcamp_workshop/domain/cat.dart';
import 'package:mdevcamp_workshop/domain/cat_breed.dart';
import 'package:mdevcamp_workshop/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase using generated options
  await Firebase.initializeApp(name: 'data-import', options: DefaultFirebaseOptions.android);
  final firestore = FirebaseFirestore.instance;

  // Import breeds
  final breedsJson = jsonDecode(await rootBundle.loadString('assets/breeds.json')) as List;
  final breeds = breedsJson
      .map((e) => CatBreed.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList();
  print('Uploading \u001b[33m${breeds.length}\u001b[0m breeds...');
  for (final breed in breeds) {
    await firestore.collection('breeds').doc(breed.id).set(breed.toJson());
  }
  print('Breeds uploaded.');

  // Import cats
  final catsJson = jsonDecode(await rootBundle.loadString('assets/cats.json')) as List;
  final cats = catsJson
      .map((e) => Cat.fromJson(Map<String, dynamic>.from(e as Map)))
      .toList();
  print('Uploading \u001b[33m${cats.length}\u001b[0m cats...');
  for (final cat in cats) {
    await firestore.collection('cats').doc(cat.id).set(cat.toJson());
  }
  print('Cats uploaded.');

  print('Firestore import complete.');
}
