// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String?,
      describtion: json['describtion'] as String?,
      name: json['name'] as String,
      type: json['type'] as int,
      status: json['status'] as int,
      priority: json['priority'] as int,
      user: json['user'] as String?,
      date: DateTime.parse(json['date'] as String),
      interval: json['interval'] == null
          ? null
          : IntervalType.fromJson(json['interval'] as Map<String, dynamic>),
      leadTime: json['leadTime'] == null
          ? null
          : IntervalType.fromJson(json['leadTime'] as Map<String, dynamic>),
      countRepeats: json['countRepeats'] as int,
      countSkips: json['countSkips'] as int,
      dateUpdate: DateTime.parse(json['dateUpdate'] as String),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'describtion': instance.describtion,
      'name': instance.name,
      'type': instance.type,
      'status': instance.status,
      'priority': instance.priority,
      'user': instance.user,
      'date': instance.date.toIso8601String(),
      'interval': instance.interval,
      'leadTime': instance.leadTime,
      'countRepeats': instance.countRepeats,
      'countSkips': instance.countSkips,
      'dateUpdate': instance.dateUpdate.toIso8601String(),
    };
