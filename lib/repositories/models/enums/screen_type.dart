import 'package:json_annotation/json_annotation.dart';

enum ScreenType {
  @JsonValue("small")
  small,

  @JsonValue("medium")
  medium,

  @JsonValue("large")
  large,

  @JsonValue("extraLarge")
  extraLarge,
}
