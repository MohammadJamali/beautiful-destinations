import 'package:json_annotation/json_annotation.dart';

enum IconClass {
  @JsonValue("IconDataSolid")
  iconDataSolid,

  @JsonValue("IconDataBrands")
  iconDataBrands,

  @JsonValue("IconDataRegular")
  iconDataRegular,

  @JsonValue("MaterialIcon")
  materialIcon,
}
