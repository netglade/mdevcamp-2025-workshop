// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cat _$CatFromJson(Map<String, dynamic> json) => Cat(
  id: json['id'] as String,
  imageUrl: json['image_url'] as String,
  name: json['name'] as String,
  breedId: json['breed_id'] as String,
  age: (json['age'] as num).toInt(),
  favoriteFood: json['favorite_food'] as String,
  afraidOfThing: json['is_afraid_of'] as String,
  price: (json['price_usd'] as num).toInt(),
  originStory: json['origin_story'] as String,
  funFact: json['fun_fact'] as String,
  breed: CatBreed.fromJson(json['breed'] as Map<String, dynamic>),
  isAdopted: json['is_adopted'] as bool? ?? false,
  adoptedBy: json['adoptedBy'] as String?,
);

Map<String, dynamic> _$CatToJson(Cat instance) => <String, dynamic>{
  'id': instance.id,
  'image_url': instance.imageUrl,
  'name': instance.name,
  'breed_id': instance.breedId,
  'age': instance.age,
  'favorite_food': instance.favoriteFood,
  'is_afraid_of': instance.afraidOfThing,
  'price_usd': instance.price,
  'origin_story': instance.originStory,
  'fun_fact': instance.funFact,
  'breed': instance.breed,
  'is_adopted': instance.isAdopted,
  'adoptedBy': instance.adoptedBy,
};
