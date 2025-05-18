// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_breed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatBreed _$CatBreedFromJson(Map<String, dynamic> json) => CatBreed(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  origin: json['origin'] as String,
  wikipediaUrl: json['wikipedia_url'] as String?,
  lifeSpan: json['life_span'] as String,
  temperament: json['temperament'] as String,
  referenceImageId: json['reference_image_id'] as String?,
  referenceImageUrl: json['reference_image_url'] as String?,
);

Map<String, dynamic> _$CatBreedToJson(CatBreed instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'origin': instance.origin,
  'wikipedia_url': instance.wikipediaUrl,
  'life_span': instance.lifeSpan,
  'temperament': instance.temperament,
  'reference_image_id': instance.referenceImageId,
  'reference_image_url': instance.referenceImageUrl,
};
