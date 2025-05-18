import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mdevcamp_workshop/domain/domain.dart';

part 'cat.g.dart';

@JsonSerializable()
class Cat extends Equatable {
  final String id;

  /// The URL of the cat image
  @JsonKey(name: 'image_url')
  final String imageUrl;
  final String name;
  @JsonKey(name: 'breed_id')
  final String breedId;
  final int age;
  @JsonKey(name: 'favorite_food')
  final String favoriteFood;
  @JsonKey(name: 'is_afraid_of')
  final String afraidOfThing;
  @JsonKey(name: 'price_usd')
  final int price;
  @JsonKey(name: 'origin_story')
  final String originStory;
  @JsonKey(name: 'fun_fact')
  final String funFact;

  final CatBreed breed;

  const Cat({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.breedId,
    required this.age,
    required this.favoriteFood,
    required this.afraidOfThing,
    required this.price,
    required this.originStory,
    required this.funFact,
    required this.breed,
  });

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

  Map<String, dynamic> toJson() => _$CatToJson(this);

  @override
  List<Object?> get props => [
    id,
    imageUrl,
    name,
    breedId,
    age,
    favoriteFood,
    afraidOfThing,
    price,
    originStory,
    funFact,
    breed,
  ];
}
