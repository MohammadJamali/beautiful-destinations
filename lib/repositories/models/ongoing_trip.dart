import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:beautiful_destinations/repositories/models/ongoing_trip_timeline.dart';

part 'ongoing_trip.g.dart';

@JsonSerializable()
class OngoingTripModel extends Equatable {
  final String id;
  final String title;
  final String location;
  final String imageUrl;
  final List<OngoingTripTimelineModel> timeline;

  const OngoingTripModel({
    required this.id,
    required this.title,
    required this.location,
    required this.imageUrl,
    required this.timeline,
  });

  @override
  List<Object?> get props => [id];

  factory OngoingTripModel.fromJson(Map<String, dynamic> json) =>
      _$OngoingTripModelFromJson(json);

  Map<String, dynamic> toJson() => _$OngoingTripModelToJson(this);
}
