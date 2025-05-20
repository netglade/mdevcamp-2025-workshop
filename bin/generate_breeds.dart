import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

void main() async {
  const apiKey = 'live_Gu6LxEqbNsrwpxg7u3t7oPjslyTCazDZyktneefAF8Z34BKDvcZMUQzthhfLUPnO'; // Vlož svůj klíč
  final breedsJson = File('assets/breeds.json').readAsStringSync();
  final breeds = json.decode(breedsJson) as List;

  for (final (index, breed) in breeds.indexed) {
    final breedId = breed['id'];
    final imageId = breed['reference_image_id'];

    final url = Uri.parse('http://api.thecatapi.com/v1/images/$imageId');

    final response = await http.get(url, headers: {'x-api-key': apiKey});

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      final imageUrl = data['url'];

      print('✅ $breedId — url fetched');

      breeds[index] = {...(breed as Map<String, dynamic>), 'reference_image_url': imageUrl};
    } else {
      print('❌ Failed to fetch $breedId: ${response.statusCode}');
    }

    await Future.delayed(const Duration(milliseconds: 200));
  }

  final outFile = File('breeds-export.json');
  await outFile.writeAsString(json.encode(breeds), flush: true);
  print('🎉 breeds-export.json created with ${breeds.length} breeds.');
}
