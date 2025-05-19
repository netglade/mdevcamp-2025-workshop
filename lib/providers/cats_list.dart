import 'package:get_it/get_it.dart';
import 'package:mdevcamp_workshop/repositories/cats_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/domain.dart';

part 'cats_list.g.dart';

@Riverpod(keepAlive: true)
class CatsList extends _$CatsList {
  final CatsRepository _catsRepository;

  CatsList({CatsRepository? catsRepository}) : _catsRepository = catsRepository ?? GetIt.I<CatsRepository>();

  @override
  Future<List<Cat>> build() async {
    print('CatsList build');

    final cats = await _catsRepository.getCats();

    return cats;
  }

  Future<void> load() async {
    try {
      state = AsyncLoading();
      final cats = await _catsRepository.getCats();

      state = AsyncData(cats);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }
}
