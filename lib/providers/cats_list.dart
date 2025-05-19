import 'package:get_it/get_it.dart';
import 'package:mdevcamp_workshop/repositories/cats_repository.dart';
import 'package:netglade_utils/netglade_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/domain.dart';

part 'cats_list.g.dart';

@Riverpod(keepAlive: true)
class CatsList extends _$CatsList {
  final CatsRepository _catsRepository;

  CatsList({CatsRepository? catsRepository}) : _catsRepository = catsRepository ?? GetIt.I<CatsRepository>();

  @override
  Future<List<Cat>> build() async {
    final cats = await _catsRepository.getCats();

    if (cats.isSuccess) {
      return cats.asSuccess;
    }

    throw cats.asError.exception;
  }

  Future<void> refresh() async {
    state = AsyncLoading();
    final cats = await _catsRepository.getCats();

    if (cats.isError) {
      state = AsyncError(cats.asError.exception, cats.asError.stackTrace ?? StackTrace.current);
    } else {
      state = AsyncData(cats.asSuccess);
    }
  }

  Future<void> adoptCat({required String catId, required String userId}) async {
    state = AsyncLoading();

    final result = await _catsRepository.adoptCat(catId: catId, userId: userId);

    if (result.isError) {
      state = AsyncError(result.asError.exception, result.asError.stackTrace ?? StackTrace.current);
    }

    final cats = state.value ?? [];
    final updatedCats = cats.map((cat) {
      if (cat.id == result.asSuccess.id) {
        return result.asSuccess;
      }
      return cat;
    }).toList();

    state = AsyncData(updatedCats);
  }
}
