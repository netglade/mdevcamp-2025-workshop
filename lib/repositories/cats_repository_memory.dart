import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/repositories/cats_repository.dart';
import 'package:netglade_utils/netglade_utils.dart';

class CatsRepositoryMemory implements CatsRepository {
  bool _isLoaded = false;

  List<Cat> _cats = [];
  List<CatBreed> _breeds = [];

  Future<void> _init() async {
    if (_isLoaded) {
      return;
    }
    _isLoaded = true;

    final catsJson = await rootBundle.loadString('assets/cats.json');
    final breedsJson = await rootBundle.loadString('assets/breeds.json');

    final cats = jsonDecode(catsJson) as List;
    final breeds = jsonDecode(breedsJson) as List;

    _cats = cats.map((cat) {
      return Cat.fromJson(cat as Map<String, dynamic>);
    }).toList();
    _breeds = breeds.map((breed) {
      return CatBreed.fromJson(breed as Map<String, dynamic>);
    }).toList();
  }

  @override
  Future<Result<Cat, RepositoryError>> adoptCat({required String catId, required String userId}) {
    try {
      final catIndex = _cats.indexWhere((cat) => cat.id == catId);

      if (catIndex == -1) {
        return Future.value(Result.error(RepositoryError(exception: 'Cat not found')));
      }

      final updatedCat = _cats[catIndex].copyWith(isAdopted: true);
      _cats[catIndex] = updatedCat;

      return Future.value(Result.success(updatedCat));
      // ignore: avoid_catches_without_on_clauses, gonna catch em all
    } catch (e, s) {
      return Future.value(Result.error(RepositoryError(exception: e, stackTrace: s)));
    }
  }

  @override
  Future<Result<List<CatBreed>, RepositoryError>> getBreeds() async {
    await _init();

    try {
      return Result.success(_breeds);
      // ignore: avoid_catches_without_on_clauses, gonna catch em all
    } catch (e, s) {
      return Result.error(RepositoryError(exception: e, stackTrace: s));
    }
  }

  @override
  Stream<Result<List<CatBreed>, RepositoryError>> getBreedsStream() async* {
    await _init();

    yield Result.success(_breeds);
  }

  @override
  Future<Result<List<Cat>, RepositoryError>> getCats({CatFilter? filter}) async {
    await _init();

    try {
      return Result.success(_cats.where((cat) => filter?.apply(cat: cat) ?? true).toList());
      // ignore: avoid_catches_without_on_clauses, gonna catch em all
    } catch (e, s) {
      return Result.error(RepositoryError(exception: e, stackTrace: s));
    }
  }

  @override
  Stream<Result<List<Cat>, RepositoryError>> getCatsStream({CatFilter? filter}) async* {
    await _init();

    yield Result.success(_cats.where((cat) => filter?.apply(cat: cat) ?? true).toList());
  }
}
