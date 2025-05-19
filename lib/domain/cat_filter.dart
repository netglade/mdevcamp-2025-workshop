import 'package:equatable/equatable.dart';
import 'package:mdevcamp_workshop/domain/cat.dart';

class CatFilter extends Equatable {
  final String? breedId;
  final String? nameQuery;
  final int? ageLimit;
  final bool isAdopted;

  const CatFilter({this.breedId, this.nameQuery, this.ageLimit, this.isAdopted = false});

  @override
  List<Object?> get props => [breedId, nameQuery, ageLimit];

  bool apply({required Cat cat}) {
    if (breedId != null && cat.breedId != breedId) {
      return false;
    }

    if (nameQuery != null && !cat.name.toLowerCase().contains(nameQuery!.toLowerCase())) {
      return false;
    }

    if (ageLimit != null && cat.age > ageLimit!) {
      return false;
    }

    return true;
  }
}
