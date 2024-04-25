// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      id: json['id'] as String?,
      describtion: json['describtion'] as String?,
      name: json['name'] as String,
      dateUpdate: DateTime.parse(json['dateUpdate'] as String),
      tasks: (json['tasks'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'describtion': instance.describtion,
      'name': instance.name,
      'dateUpdate': instance.dateUpdate.toIso8601String(),
      'tasks': instance.tasks,
    };
