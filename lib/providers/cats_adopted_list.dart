import 'package:get_it/get_it.dart';
import 'package:mdevcamp_workshop/providers/cats_list.dart';
import 'package:mdevcamp_workshop/repositories/cats_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/domain.dart';

part 'cats_adopted_list.g.dart';

@Riverpod(keepAlive: false)
class CatsAdoptedList extends _$CatsAdoptedList {
  final CatsRepository _catsRepository;

  CatsAdoptedList({CatsRepository? catsRepository}) : _catsRepository = catsRepository ?? GetIt.I<CatsRepository>();

  @override
  Future<List<Cat>> build() async {
    final cats = ref.watch(catsListProvider);

    if (cats.isLoading) {
      state = AsyncLoading();
      return [];
    }

    if (cats.hasError) {
      state = AsyncError(cats.error ?? '', cats.stackTrace ?? StackTrace.current);

      throw cats.error!;
    }

    final catsList = cats.value!;
    // TODO(firebase): Filter by signed in user.
    return catsList.where((x) => x.isAdopted).toList();
  }

  Future<void> refresh() async {
    final cats = ref.watch(catsListProvider);

    if (cats.isLoading) {
      state = AsyncLoading();
    }

    if (cats.hasError) {
      state = AsyncError(cats.error ?? '', cats.stackTrace ?? StackTrace.current);
    }

    final catsList = cats.value!;
    // TODO(firebase): Filter by signed in user.
    state = AsyncData(catsList);
  }
}
