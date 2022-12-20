// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ongoing_trip_timeline.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OngoingTripTimelineModel _$OngoingTripTimelineModelFromJson(
        Map<String, dynamic> json) =>
    OngoingTripTimelineModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      date: json['date'] as String,
      done: json['done'] as bool,
      iconClass: $enumDecode(_$IconClassEnumMap, json['iconClass']),
      icon: json['icon'] as int,
      time: json['time'] as String?,
    );

Map<String, dynamic> _$OngoingTripTimelineModelToJson(
        OngoingTripTimelineModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'done': instance.done,
      'date': instance.date,
      'time': instance.time,
      'iconClass': _$IconClassEnumMap[instance.iconClass]!,
      'icon': instance.icon,
    };

const _$IconClassEnumMap = {
  IconClass.iconDataSolid: 'IconDataSolid',
  IconClass.iconDataBrands: 'IconDataBrands',
  IconClass.iconDataRegular: 'IconDataRegular',
  IconClass.materialIcon: 'MaterialIcon',
};
