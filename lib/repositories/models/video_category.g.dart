// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceCategoryModel _$PlaceCategoryModelFromJson(Map<String, dynamic> json) =>
    PlaceCategoryModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      blurhash: json['blurhash'] as String,
      imageUrl: json['imageUrl'] as String,
    );

Map<String, dynamic> _$PlaceCategoryModelToJson(PlaceCategoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'blurhash': instance.blurhash,
      'imageUrl': instance.imageUrl,
    };
