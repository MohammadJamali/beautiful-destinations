// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tiktok.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TiktokModel _$TiktokModelFromJson(Map<String, dynamic> json) => TiktokModel(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      video: json['video'] as String,
      isLiked: json['isLiked'] as bool? ?? false,
      description: json['description'] as String?,
      likes: json['likes'] as int? ?? 0,
      comments: json['comments'] as int? ?? 0,
    );

Map<String, dynamic> _$TiktokModelToJson(TiktokModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'video': instance.video,
      'likes': instance.likes,
      'comments': instance.comments,
      'isLiked': instance.isLiked,
    };
