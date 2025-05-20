import 'package:equatable/equatable.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/providers/cats_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cats_filtered_list.g.dart';

class FilteredCats extends Equatable {
  final CatFilter? filter;
  final List<Cat> cats;

  bool get hasFilter => filter != null;

  const FilteredCats({required this.filter, required this.cats});

  @override
  List<Object?> get props => [filter, cats];
}

@Riverpod(keepAlive: true)
class CatsFilteredList extends _$CatsFilteredList {
  @override
  Future<FilteredCats> build() async {
    final cats = await ref.watch(catsListProvider.future);
    final filter = state.value?.filter ?? const CatFilter();

    final filtered = cats.where((cat) {
      return filter.apply(cat: cat);
    }).toList();

    return FilteredCats(
      filter: state.value?.filter,
      cats: filtered,
    );
  }

  Future<void> clearFilter() async {
    state = const AsyncLoading();

    final allCats = await ref.read(catsListProvider.future);

    state = AsyncData(FilteredCats(filter: null, cats: allCats));
  }

  Future<void> setFilter(CatFilter filter) async {
    state = const AsyncLoading();

    final allCats = await ref.read(catsListProvider.future);
    final filtered = allCats.where((cat) {
      return filter.apply(cat: cat);
    }).toList();

    state = AsyncData(FilteredCats(filter: filter, cats: filtered));
  }
}
