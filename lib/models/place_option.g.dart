// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlaceOptionModel _$PlaceOptionModelFromJson(Map<String, dynamic> json) =>
    PlaceOptionModel(
      iconClass: $enumDecode(_$IconClassEnumMap, json['iconClass']),
      icon: json['icon'] as int,
      value: json['value'] as String,
    );

Map<String, dynamic> _$PlaceOptionModelToJson(PlaceOptionModel instance) =>
    <String, dynamic>{
      'iconClass': _$IconClassEnumMap[instance.iconClass]!,
      'icon': instance.icon,
      'value': instance.value,
    };

const _$IconClassEnumMap = {
  IconClass.iconDataSolid: 'IconDataSolid',
  IconClass.iconDataBrands: 'IconDataBrands',
  IconClass.iconDataRegular: 'IconDataRegular',
  IconClass.materialIcon: 'MaterialIcon',
};
