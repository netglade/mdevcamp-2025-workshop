import 'package:get_it/get_it.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/providers/cats_list.dart';
import 'package:mdevcamp_workshop/repositories/cats_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cats_adopted_list.g.dart';

@Riverpod(keepAlive: false)
class CatsAdoptedList extends _$CatsAdoptedList {
  final CatsRepository _catsRepository;

  CatsAdoptedList({CatsRepository? catsRepository}) : _catsRepository = catsRepository ?? GetIt.I<CatsRepository>();

  @override
  Future<List<Cat>> build() async {
    final cats = await ref.watch(catsListProvider.future);

    // TODO(firebase): Filter by signed in user.
    return cats.where((x) => x.isAdopted).toList();
  }

  Future<void> refresh() async {
    final cats = await ref.watch(catsListProvider.future);

    state = AsyncData(cats.where((x) => x.isAdopted).toList());
  }
}
