// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceDetailsModel _$PlaceDetailsModelFromJson(Map<String, dynamic> json) =>
    PlaceDetailsModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      likes: json['likes'] as int,
      comments: json['comments'] as int,
      thumbnails: (json['thumbnails'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      options: (json['options'] as List<dynamic>)
          .map((e) => PlaceOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlaceDetailsModelToJson(PlaceDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'likes': instance.likes,
      'comments': instance.comments,
      'thumbnails': instance.thumbnails,
      'pricePerDay': instance.pricePerDay,
      'options': instance.options,
    };
