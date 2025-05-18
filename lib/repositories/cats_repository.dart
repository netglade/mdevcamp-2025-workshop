import 'package:mdevcamp_workshop/domain/cat.dart';
import 'package:mdevcamp_workshop/domain/cat_breed.dart';
import 'package:mdevcamp_workshop/domain/cat_filter.dart';

abstract interface class CatsRepository {
  Future<List<Cat>> getCats({CatFilter? filter});

  Stream<List<Cat>> getCatsStream({CatFilter? filter});

  Future<List<CatBreed>> getBreeds();

  Stream<List<CatBreed>> getBreedsStream();
}
