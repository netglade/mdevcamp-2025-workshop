import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_page_bottom_nav_notifier.g.dart';

@riverpod
class HomePageBottomNavNotifier extends _$HomePageBottomNavNotifier {
  @override
  int build() {
    return 0;
  }

  void setIndex(int index) {
    state = index;
  }
}
