import 'package:json_annotation/json_annotation.dart';

import 'place.dart';

part 'video_category.g.dart';

@JsonSerializable()
class PlaceCategoryModel extends PlaceModel {
  final String blurhash;
  final String imageUrl;

  const PlaceCategoryModel({
    required String id,
    required String title,
    required String description,
    required this.blurhash,
    required this.imageUrl,
  }) : super(id: id, title: title, description: description);

  @override
  List<Object?> get props => [id];

  @override
  factory PlaceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$PlaceCategoryModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PlaceCategoryModelToJson(this);
}
