import 'package:beautiful_destinations/models/place_option.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_details.g.dart';

@JsonSerializable()
class PlaceDetailsModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final int likes;
  final int comments;
  final List<String> thumbnails;
  final double pricePerDay;
  final List<PlaceOptionModel> options;

  const PlaceDetailsModel({
    required this.id,
    required this.title,
    required this.description,
    required this.likes,
    required this.comments,
    required this.thumbnails,
    required this.pricePerDay,
    required this.options,
  });

  @override
  List<Object?> get props => [id];

  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceDetailsModelToJson(this);
}
