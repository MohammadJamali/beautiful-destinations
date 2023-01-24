import 'package:beautiful_destinations/repositories/models/enums/icon_class.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ongoing_trip_timeline.g.dart';

@JsonSerializable()
class OngoingTripTimelineModel extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool done;
  final String date;
  final String? time;
  final IconClass iconClass;
  final int icon;

  const OngoingTripTimelineModel({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.done,
    required this.iconClass,
    required this.icon,
    this.time,
  });

  @override
  List<Object?> get props => [id];

  factory OngoingTripTimelineModel.fromJson(Map<String, dynamic> json) =>
      _$OngoingTripTimelineModelFromJson(json);

  Map<String, dynamic> toJson() => _$OngoingTripTimelineModelToJson(this);
}
