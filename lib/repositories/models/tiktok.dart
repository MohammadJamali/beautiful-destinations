import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'tiktok.g.dart';

@JsonSerializable()
class TiktokModel extends Equatable {
  final String id;
  final String title;
  final String? description;
  final String imageUrl;
  final String video;

  final int likes;
  final int comments;

  final bool isLiked;

  const TiktokModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.video,
    this.isLiked = false,
    this.description,
    this.likes = 0,
    this.comments = 0,
  });

  @override
  List<Object?> get props => [id];

  factory TiktokModel.fromJson(Map<String, dynamic> json) =>
      _$TiktokModelFromJson(json);

  Map<String, dynamic> toJson() => _$TiktokModelToJson(this);
}
