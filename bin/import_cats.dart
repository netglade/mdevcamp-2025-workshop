import 'dart:convert';
import 'dart:io';

import 'package:faker/faker.dart';
import 'package:http/http.dart' as http;

void main() async {
  final faker = Faker();
  final apiKey = 'YOUR_API_KEY'; // Vlož svůj klíč
  final breedsJson = File('assets/breeds.json').readAsStringSync();
  final breeds = json.decode(breedsJson) as List;

  final List<Map<String, dynamic>> cats = [];

  final favoriteFoods = [
    "tuna sushi",
    "chicken liver pâté",
    "salmon tartare",
    "whipped cream on toast",
    "grilled shrimp tails",
    "melted cheese",
    "catnip ice cream",
    "anchovy pizza",
    "crunchy mouse nuggets",
    "bacon strips",
  ];

  final fears = [
    "vacuum cleaner",
    "cucumber",
    "thunder",
    "plastic bags",
    "doorbell",
    "fireworks",
    "water spray",
    "blender noise",
    "strangers",
    "robot vacuum",
    "hair dryer",
    "zucchini",
    "the vet",
  ];

  for (final breed in breeds) {
    final breedId = breed['id'];
    final lifeSpanStr = breed['life_span'] ?? '20';
    final maxLife = _parseMaxLifeSpan(lifeSpanStr);

    final url = Uri.parse('http://api.thecatapi.com/v1/images/search?breed_ids=$breedId&limit=10');

    final response = await http.get(url, headers: {'x-api-key': apiKey});

    if (response.statusCode == 200) {
      final images = json.decode(response.body) as List;
      for (final image in images) {
        cats.add({
          'id': image['id'],
          'url': image['url'],
          'name': faker.person.firstName(),
          'breed_id': breedId,
          'age': faker.randomGenerator.integer(maxLife + 2),
          'favorite_food': faker.randomGenerator.element(favoriteFoods),
          'is_afraid_of': faker.randomGenerator.element(fears),
        });
      }
      print('✅ $breedId — ${images.length} cats fetched');
    } else {
      print('❌ Failed to fetch $breedId: ${response.statusCode}');
    }

    await Future.delayed(Duration(milliseconds: 200));
  }

  final outFile = File('cats.json');
  await outFile.writeAsString(json.encode(cats), flush: true);
  print('🎉 cats.json created with ${cats.length} cats.');
}

int _parseMaxLifeSpan(String span) {
  try {
    if (span.contains('-')) {
      final parts = span.split('-');
      return int.parse(parts[1].trim());
    } else {
      return int.parse(span.trim());
    }
  } catch (_) {
    return 20;
  }
}
