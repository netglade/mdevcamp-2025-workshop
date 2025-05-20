import 'package:equatable/equatable.dart';
import 'package:mdevcamp_workshop/domain/cat.dart';

class CatFilter extends Equatable {
  final Set<String>? breeds;

  const CatFilter({this.breeds});

  @override
  List<Object?> get props => [breeds];

  bool apply({required Cat cat}) {
    if (breeds case final bredsValue? when !bredsValue.contains(cat.breedId) && bredsValue.isNotEmpty) {
      return false;
    }

    return true;
  }
}
