import 'package:json_annotation/json_annotation.dart';

part 'alarm.g.dart';

@JsonSerializable()
class Alarm {
  final double latitude;
  final double longitude;
  final String alarmMode;
  final double distance;

  const Alarm({
    required this.latitude,
    required this.longitude,
    required this.alarmMode,
    required this.distance,
  });

  factory Alarm.fromJson(Map<String, dynamic> json) => _$AlarmFromJson(json);

  /// Connect the generated [_$AlarmToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$AlarmToJson(this);

}