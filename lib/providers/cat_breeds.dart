import 'package:get_it/get_it.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/repositories/cats_repository.dart';
import 'package:netglade_utils/netglade_utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cat_breeds.g.dart';

@Riverpod(keepAlive: true)
class CatBreeds extends _$CatBreeds {
  final CatsRepository _catsRepository;

  CatBreeds({CatsRepository? catsRepository}) : _catsRepository = catsRepository ?? GetIt.I<CatsRepository>();

  @override
  Future<List<CatBreed>> build() async {
    final breeds = await _catsRepository.getBreeds();

    if (breeds.isSuccess) return breeds.asSuccess;

    // ignore: only_throw_errors, ok to throw - riverpod will handle it for us
    throw breeds.asError.exception;
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    final breeds = await _catsRepository.getBreeds();

    if (breeds.isError) {
      state = AsyncError(breeds.asError.exception, breeds.asError.stackTrace ?? StackTrace.current);
    } else {
      state = AsyncData(breeds.asSuccess);
    }
  }
}
