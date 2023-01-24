import 'package:beautiful_destinations/repositories/models/place.dart';
import 'package:beautiful_destinations/repositories/models/place_option.dart';
import 'package:json_annotation/json_annotation.dart';

part 'place_details.g.dart';

@JsonSerializable()
class PlaceDetailsModel extends PlaceModel {
  final int likes;
  final int comments;
  final List<String> thumbnails;
  final double pricePerDay;
  final List<PlaceOptionModel> options;

  const PlaceDetailsModel({
    required String id,
    required String title,
    required String description,
    required this.likes,
    required this.comments,
    required this.thumbnails,
    required this.pricePerDay,
    required this.options,
  }) : super(id: id, title: title, description: description);

  @override
  List<Object?> get props => [id];

  @override
  factory PlaceDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceDetailsModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlaceDetailsModelToJson(this);
}
