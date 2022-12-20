import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable()
class PlaceModel extends Equatable {
  final String id;
  final String title;
  final String description;

  const PlaceModel({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [id];

  factory PlaceModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceModelToJson(this);
}
