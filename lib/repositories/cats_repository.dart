import 'package:mdevcamp_workshop/domain/cat.dart';
import 'package:mdevcamp_workshop/domain/cat_breed.dart';
import 'package:mdevcamp_workshop/domain/cat_filter.dart';
import 'package:netglade_utils/netglade_utils.dart';

abstract interface class CatsRepository {
  Future<Result<List<Cat>, RepositoryError>> getCats({CatFilter? filter});

  Stream<Result<List<Cat>, RepositoryError>> getCatsStream({CatFilter? filter});

  Future<Result<List<CatBreed>, RepositoryError>> getBreeds();

  Stream<Result<List<CatBreed>, RepositoryError>> getBreedsStream();

  Future<Result<Cat, RepositoryError>> adoptCat({required String catId, required String userId});
}

class RepositoryError {
  final Object exception;
  final StackTrace? stackTrace;

  RepositoryError({required this.exception, this.stackTrace});
}
