// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group_of_rooms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroupOfRoomsImpl _$$GroupOfRoomsImplFromJson(Map<String, dynamic> json) =>
    _$GroupOfRoomsImpl(
      id: json['id'] as String?,
      author: json['author'] as String,
      describtion: json['describtion'] as String?,
      name: json['name'] as String,
      dateUpdate: DateTime.parse(json['dateUpdate'] as String),
      users: (json['users'] as List<dynamic>).map((e) => e as String).toList(),
      rooms: (json['rooms'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$GroupOfRoomsImplToJson(_$GroupOfRoomsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'author': instance.author,
      'describtion': instance.describtion,
      'name': instance.name,
      'dateUpdate': instance.dateUpdate.toIso8601String(),
      'users': instance.users,
      'rooms': instance.rooms,
    };
