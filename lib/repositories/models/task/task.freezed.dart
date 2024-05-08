// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String? get id => throw _privateConstructorUsedError;
  String? get describtion => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get type => throw _privateConstructorUsedError;
  int get status => throw _privateConstructorUsedError;
  int get priority => throw _privateConstructorUsedError;
  String? get user => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  IntervalType? get interval => throw _privateConstructorUsedError;
  IntervalType? get leadTime => throw _privateConstructorUsedError;
  int get countRepeats => throw _privateConstructorUsedError;
  int get countSkips => throw _privateConstructorUsedError;
  DateTime get dateUpdate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) =
      _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String? id,
      String? describtion,
      String name,
      int type,
      int status,
      int priority,
      String? user,
      DateTime date,
      IntervalType? interval,
      IntervalType? leadTime,
      int countRepeats,
      int countSkips,
      DateTime dateUpdate});

  $IntervalTypeCopyWith<$Res>? get interval;
  $IntervalTypeCopyWith<$Res>? get leadTime;
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task>
    implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? describtion = freezed,
    Object? name = null,
    Object? type = null,
    Object? status = null,
    Object? priority = null,
    Object? user = freezed,
    Object? date = null,
    Object? interval = freezed,
    Object? leadTime = freezed,
    Object? countRepeats = null,
    Object? countSkips = null,
    Object? dateUpdate = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      describtion: freezed == describtion
          ? _value.describtion
          : describtion // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      interval: freezed == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as IntervalType?,
      leadTime: freezed == leadTime
          ? _value.leadTime
          : leadTime // ignore: cast_nullable_to_non_nullable
              as IntervalType?,
      countRepeats: null == countRepeats
          ? _value.countRepeats
          : countRepeats // ignore: cast_nullable_to_non_nullable
              as int,
      countSkips: null == countSkips
          ? _value.countSkips
          : countSkips // ignore: cast_nullable_to_non_nullable
              as int,
      dateUpdate: null == dateUpdate
          ? _value.dateUpdate
          : dateUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $IntervalTypeCopyWith<$Res>? get interval {
    if (_value.interval == null) {
      return null;
    }

    return $IntervalTypeCopyWith<$Res>(_value.interval!, (value) {
      return _then(_value.copyWith(interval: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $IntervalTypeCopyWith<$Res>? get leadTime {
    if (_value.leadTime == null) {
      return null;
    }

    return $IntervalTypeCopyWith<$Res>(_value.leadTime!, (value) {
      return _then(_value.copyWith(leadTime: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(
          _$TaskImpl value, $Res Function(_$TaskImpl) then) =
      __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? describtion,
      String name,
      int type,
      int status,
      int priority,
      String? user,
      DateTime date,
      IntervalType? interval,
      IntervalType? leadTime,
      int countRepeats,
      int countSkips,
      DateTime dateUpdate});

  @override
  $IntervalTypeCopyWith<$Res>? get interval;
  @override
  $IntervalTypeCopyWith<$Res>? get leadTime;
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res>
    extends _$TaskCopyWithImpl<$Res, _$TaskImpl>
    implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? describtion = freezed,
    Object? name = null,
    Object? type = null,
    Object? status = null,
    Object? priority = null,
    Object? user = freezed,
    Object? date = null,
    Object? interval = freezed,
    Object? leadTime = freezed,
    Object? countRepeats = null,
    Object? countSkips = null,
    Object? dateUpdate = null,
  }) {
    return _then(_$TaskImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      describtion: freezed == describtion
          ? _value.describtion
          : describtion // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as int,
      priority: null == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as String?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      interval: freezed == interval
          ? _value.interval
          : interval // ignore: cast_nullable_to_non_nullable
              as IntervalType?,
      leadTime: freezed == leadTime
          ? _value.leadTime
          : leadTime // ignore: cast_nullable_to_non_nullable
              as IntervalType?,
      countRepeats: null == countRepeats
          ? _value.countRepeats
          : countRepeats // ignore: cast_nullable_to_non_nullable
              as int,
      countSkips: null == countSkips
          ? _value.countSkips
          : countSkips // ignore: cast_nullable_to_non_nullable
              as int,
      dateUpdate: null == dateUpdate
          ? _value.dateUpdate
          : dateUpdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskImpl extends _Task {
  _$TaskImpl(
      {this.id,
      this.describtion,
      required this.name,
      required this.type,
      required this.status,
      required this.priority,
      this.user,
      required this.date,
      this.interval,
      this.leadTime,
      required this.countRepeats,
      required this.countSkips,
      required this.dateUpdate})
      : super._();

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskImplFromJson(json);

  @override
  final String? id;
  @override
  final String? describtion;
  @override
  final String name;
  @override
  final int type;
  @override
  final int status;
  @override
  final int priority;
  @override
  final String? user;
  @override
  final DateTime date;
  @override
  final IntervalType? interval;
  @override
  final IntervalType? leadTime;
  @override
  final int countRepeats;
  @override
  final int countSkips;
  @override
  final DateTime dateUpdate;

  @override
  String toString() {
    return 'Task(id: $id, describtion: $describtion, name: $name, type: $type, status: $status, priority: $priority, user: $user, date: $date, interval: $interval, leadTime: $leadTime, countRepeats: $countRepeats, countSkips: $countSkips, dateUpdate: $dateUpdate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.describtion, describtion) ||
                other.describtion == describtion) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.leadTime, leadTime) ||
                other.leadTime == leadTime) &&
            (identical(other.countRepeats, countRepeats) ||
                other.countRepeats == countRepeats) &&
            (identical(other.countSkips, countSkips) ||
                other.countSkips == countSkips) &&
            (identical(other.dateUpdate, dateUpdate) ||
                other.dateUpdate == dateUpdate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      describtion,
      name,
      type,
      status,
      priority,
      user,
      date,
      interval,
      leadTime,
      countRepeats,
      countSkips,
      dateUpdate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task extends Task {
  factory _Task(
      {final String? id,
      final String? describtion,
      required final String name,
      required final int type,
      required final int status,
      required final int priority,
      final String? user,
      required final DateTime date,
      final IntervalType? interval,
      final IntervalType? leadTime,
      required final int countRepeats,
      required final int countSkips,
      required final DateTime dateUpdate}) = _$TaskImpl;
  _Task._() : super._();

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  String? get id;
  @override
  String? get describtion;
  @override
  String get name;
  @override
  int get type;
  @override
  int get status;
  @override
  int get priority;
  @override
  String? get user;
  @override
  DateTime get date;
  @override
  IntervalType? get interval;
  @override
  IntervalType? get leadTime;
  @override
  int get countRepeats;
  @override
  int get countSkips;
  @override
  DateTime get dateUpdate;
  @override
  @JsonKey(ignore: true)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
