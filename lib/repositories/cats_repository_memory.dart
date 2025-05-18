import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:mdevcamp_workshop/repositories/cats_repository.dart';

import '../domain/domain.dart';

class CatsRepositoryMemory implements CatsRepository {
  bool _isLoaded = false;

  List<Cat> _cats = [];
  List<CatBreed> _breeds = [];

  Future<void> _init() async {
    if (_isLoaded) {
      return;
    }

    final catsJson = await rootBundle.loadString('assets/cats.json');
    final breedsJson = await rootBundle.loadString('assets/breeds.json');

    final cats = jsonDecode(catsJson) as List;
    final breeds = jsonDecode(breedsJson) as List;

    _cats =
        cats.map((cat) {
          return Cat.fromJson(cat);
        }).toList();
    _breeds =
        breeds.map((breed) {
          return CatBreed.fromJson(breed);
        }).toList();

    _isLoaded = true;
  }

  @override
  Future<List<Cat>> getCats({CatFilter? filter}) async {
    await _init();

    return _cats.where((cat) => filter?.apply(cat: cat) ?? true).toList();
  }

  @override
  Stream<List<Cat>> getCatsStream({CatFilter? filter}) async* {
    await _init();

    yield* Stream.value(_cats.where((cat) => filter?.apply(cat: cat) ?? true).toList());
  }

  @override
  Future<List<CatBreed>> getBreeds() async {
    await _init();
    return _breeds;
  }

  @override
  Stream<List<CatBreed>> getBreedsStream() async* {
    await _init();

    yield* Stream.value(_breeds);
  }
}
