import 'package:get_it/get_it.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/repositories/cats_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cat_breeds.g.dart';

@Riverpod(keepAlive: true)
class CatBreeds extends _$CatBreeds {
  final CatsRepository _catsRepository;

  CatBreeds({CatsRepository? catsRepository}) : _catsRepository = catsRepository ?? GetIt.I<CatsRepository>();

  @override
  Future<List<CatBreed>> build() async {
    print('CatBreeds build');
    final breeds = await _catsRepository.getBreeds();

    return breeds;
  }

  Future<void> load() async {
    try {
      state = AsyncLoading();
      final breeds = await _catsRepository.getBreeds();

      state = AsyncData(breeds);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }
}
