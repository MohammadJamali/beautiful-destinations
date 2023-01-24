import 'package:beautiful_destinations/repositories/models/enums/icon_class.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_option.g.dart';

@JsonSerializable()
class PlaceOptionModel extends Equatable {
  final IconClass iconClass;
  final int icon;
  final String value;

  const PlaceOptionModel({
    required this.iconClass,
    required this.icon,
    required this.value,
  });

  @override
  List<Object?> get props => [iconClass, icon, value];

  factory PlaceOptionModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceOptionModelToJson(this);
}
