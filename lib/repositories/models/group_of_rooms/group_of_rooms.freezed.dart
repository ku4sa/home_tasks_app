// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_of_rooms.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroupOfRooms _$GroupOfRoomsFromJson(Map<String, dynamic> json) {
  return _GroupOfRooms.fromJson(json);
}

/// @nodoc
mixin _$GroupOfRooms {
  String? get id => throw _privateConstructorUsedError;
  String get author => throw _privateConstructorUsedError;
  String? get describtion => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  DateTime get dateUpdate => throw _privateConstructorUsedError;
  List<String> get users => throw _privateConstructorUsedError;
  List<String> get rooms => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupOfRoomsCopyWith<GroupOfRooms> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupOfRoomsCopyWith<$Res> {
  factory $GroupOfRoomsCopyWith(
          GroupOfRooms value, $Res Function(GroupOfRooms) then) =
      _$GroupOfRoomsCopyWithImpl<$Res, GroupOfRooms>;
  @useResult
  $Res call(
      {String? id,
      String author,
      String? describtion,
      String name,
      DateTime dateUpdate,
      List<String> users,
      List<String> rooms});
}

/// @nodoc
class _$GroupOfRoomsCopyWithImpl<$Res, $Val extends GroupOfRooms>
    implements $GroupOfRoomsCopyWith<$Res> {
  _$GroupOfRoomsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? author = null,
    Object? describtion = freezed,
    Object? name = null,
    Object? dateUpdate = null,
    Object? users = null,
    Object? rooms = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      describtion: freezed == describtion
          ? _value.describtion
          : describtion // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateUpdate: null == dateUpdate
          ? _value.dateUpdate
          : dateUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rooms: null == rooms
          ? _value.rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroupOfRoomsImplCopyWith<$Res>
    implements $GroupOfRoomsCopyWith<$Res> {
  factory _$$GroupOfRoomsImplCopyWith(
          _$GroupOfRoomsImpl value, $Res Function(_$GroupOfRoomsImpl) then) =
      __$$GroupOfRoomsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String author,
      String? describtion,
      String name,
      DateTime dateUpdate,
      List<String> users,
      List<String> rooms});
}

/// @nodoc
class __$$GroupOfRoomsImplCopyWithImpl<$Res>
    extends _$GroupOfRoomsCopyWithImpl<$Res, _$GroupOfRoomsImpl>
    implements _$$GroupOfRoomsImplCopyWith<$Res> {
  __$$GroupOfRoomsImplCopyWithImpl(
      _$GroupOfRoomsImpl _value, $Res Function(_$GroupOfRoomsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? author = null,
    Object? describtion = freezed,
    Object? name = null,
    Object? dateUpdate = null,
    Object? users = null,
    Object? rooms = null,
  }) {
    return _then(_$GroupOfRoomsImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      describtion: freezed == describtion
          ? _value.describtion
          : describtion // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      dateUpdate: null == dateUpdate
          ? _value.dateUpdate
          : dateUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<String>,
      rooms: null == rooms
          ? _value.rooms
          : rooms // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GroupOfRoomsImpl implements _GroupOfRooms {
  const _$GroupOfRoomsImpl(
      {required this.id,
      required this.author,
      required this.describtion,
      required this.name,
      required this.dateUpdate,
      required this.users,
      required this.rooms});

  factory _$GroupOfRoomsImpl.fromJson(Map<String, dynamic> json) =>
      _$$GroupOfRoomsImplFromJson(json);

  @override
  final String? id;
  @override
  final String author;
  @override
  final String? describtion;
  @override
  final String name;
  @override
  final DateTime dateUpdate;
  @override
  final List<String> users;
  @override
  final List<String> rooms;

  @override
  String toString() {
    return 'GroupOfRooms(id: $id, author: $author, describtion: $describtion, name: $name, dateUpdate: $dateUpdate, users: $users, rooms: $rooms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroupOfRoomsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.describtion, describtion) ||
                other.describtion == describtion) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.dateUpdate, dateUpdate) ||
                other.dateUpdate == dateUpdate) &&
            const DeepCollectionEquality().equals(other.users, users) &&
            const DeepCollectionEquality().equals(other.rooms, rooms));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      author,
      describtion,
      name,
      dateUpdate,
      const DeepCollectionEquality().hash(users),
      const DeepCollectionEquality().hash(rooms));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GroupOfRoomsImplCopyWith<_$GroupOfRoomsImpl> get copyWith =>
      __$$GroupOfRoomsImplCopyWithImpl<_$GroupOfRoomsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroupOfRoomsImplToJson(
      this,
    );
  }
}

abstract class _GroupOfRooms implements GroupOfRooms {
  const factory _GroupOfRooms(
      {required final String? id,
      required final String author,
      required final String? describtion,
      required final String name,
      required final DateTime dateUpdate,
      required final List<String> users,
      required final List<String> rooms}) = _$GroupOfRoomsImpl;

  factory _GroupOfRooms.fromJson(Map<String, dynamic> json) =
      _$GroupOfRoomsImpl.fromJson;

  @override
  String? get id;
  @override
  String get author;
  @override
  String? get describtion;
  @override
  String get name;
  @override
  DateTime get dateUpdate;
  @override
  List<String> get users;
  @override
  List<String> get rooms;
  @override
  @JsonKey(ignore: true)
  _$$GroupOfRoomsImplCopyWith<_$GroupOfRoomsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
