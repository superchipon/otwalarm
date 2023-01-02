// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'alarm.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Alarm _$AlarmFromJson(Map<String, dynamic> json) => Alarm(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      alarmMode: json['alarmMode'] as String,
      distance: (json['distance'] as num).toDouble(),
    );

Map<String, dynamic> _$AlarmToJson(Alarm instance) => <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'alarmMode': instance.alarmMode,
      'distance': instance.distance,
    };
