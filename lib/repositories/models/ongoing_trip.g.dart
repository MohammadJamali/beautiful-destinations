// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ongoing_trip.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OngoingTripModel _$OngoingTripModelFromJson(Map<String, dynamic> json) =>
    OngoingTripModel(
      id: json['id'] as String,
      title: json['title'] as String,
      location: json['location'] as String,
      imageUrl: json['imageUrl'] as String,
      timeline: (json['timeline'] as List<dynamic>)
          .map((e) =>
              OngoingTripTimelineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OngoingTripModelToJson(OngoingTripModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'location': instance.location,
      'imageUrl': instance.imageUrl,
      'timeline': instance.timeline,
    };
