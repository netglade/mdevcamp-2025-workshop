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

  @JsonKey(name: 'is_adopted', defaultValue: false)
  final bool isAdopted;

  final String? adoptedBy;

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
    this.isAdopted = false,
    this.adoptedBy,
  });

  factory Cat.fromJson(Map<String, dynamic> json) => _$CatFromJson(json);

  Map<String, dynamic> toJson() => _$CatToJson(this);

  Cat copyWith({
    String? id,
    String? imageUrl,
    String? name,
    String? breedId,
    int? age,
    String? favoriteFood,
    String? afraidOfThing,
    int? price,
    String? originStory,
    String? funFact,
    CatBreed? breed,
    bool? isAdopted,
    String? adoptedBy,
  }) {
    return Cat(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      breedId: breedId ?? this.breedId,
      age: age ?? this.age,
      favoriteFood: favoriteFood ?? this.favoriteFood,
      afraidOfThing: afraidOfThing ?? this.afraidOfThing,
      price: price ?? this.price,
      originStory: originStory ?? this.originStory,
      funFact: funFact ?? this.funFact,
      breed: breed ?? this.breed,
      isAdopted: isAdopted ?? this.isAdopted,
      adoptedBy: adoptedBy ?? this.adoptedBy,
    );
  }

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
    isAdopted,
    adoptedBy,
  ];
}
