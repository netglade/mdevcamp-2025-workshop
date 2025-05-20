import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cat_breed.g.dart';

@JsonSerializable()
class CatBreed extends Equatable {
  final String id;
  final String name;
  final String description;
  final String origin;
  @JsonKey(name: 'wikipedia_url')
  final String? wikipediaUrl;
  @JsonKey(name: 'life_span')
  final String lifeSpan;
  final String temperament;
  @JsonKey(name: 'reference_image_id')
  final String? referenceImageId;
  @JsonKey(name: 'reference_image_url')
  final String? referenceImageUrl;

  const CatBreed({
    required this.id,
    required this.name,
    required this.description,
    required this.origin,
    required this.wikipediaUrl,
    required this.lifeSpan,
    required this.temperament,
    required this.referenceImageId,
    required this.referenceImageUrl,
  });

  factory CatBreed.fromJson(Map<String, dynamic> json) => _$CatBreedFromJson(json);

  Map<String, dynamic> toJson() => _$CatBreedToJson(this);

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    origin,
    wikipediaUrl,
    lifeSpan,
    temperament,
    referenceImageId,
    referenceImageUrl,
  ];
}
