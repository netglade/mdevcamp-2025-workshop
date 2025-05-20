import 'package:mdevcamp_workshop/domain/domain.dart';
import 'package:mdevcamp_workshop/providers/cats_list.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'basket.g.dart';

@Riverpod()
class Basket extends _$Basket {
  @override
  Set<Cat> build() {
    return {};
  }

  void addToBasket(Cat cat) {
    state = {...state, cat};
  }

  void removeFromBasket(Cat cat) {
    state = state.where((c) => c != cat).toSet();
  }

  void confirmBuy() {
    final adoptedNotifier = ref.read(catsListProvider.notifier);
    for (final cat in state) {
      adoptedNotifier.adoptCat(
        catId: cat.id,
        userId: 'userId', // TODO(firebase): Replace with actual user ID
      );
    }

    state = {};
  }
}
