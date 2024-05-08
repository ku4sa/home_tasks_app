// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'interval.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$IntervalImpl _$$IntervalImplFromJson(Map<String, dynamic> json) =>
    _$IntervalImpl(
      days: json['days'] as int? ?? 0,
      hours: json['hours'] as int? ?? 0,
      minutes: json['minutes'] as int? ?? 0,
      seconds: json['seconds'] as int? ?? 0,
      milliseconds: json['milliseconds'] as int? ?? 0,
      ticks: json['ticks'] as int? ?? 0,
    );

Map<String, dynamic> _$$IntervalImplToJson(_$IntervalImpl instance) =>
    <String, dynamic>{
      'days': instance.days,
      'hours': instance.hours,
      'minutes': instance.minutes,
      'seconds': instance.seconds,
      'milliseconds': instance.milliseconds,
      'ticks': instance.ticks,
    };
