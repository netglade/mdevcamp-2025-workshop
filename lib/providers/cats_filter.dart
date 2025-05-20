import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cats_filter.g.dart';

@Riverpod(keepAlive: true)
class CatsFilter extends _$CatsFilter {
  @override
  CatFilter? build() {
    return null;
  }

  void clearFilter() {
    state = null;
  }

  void setFilter(CatFilter filter) => state = filter;
}
