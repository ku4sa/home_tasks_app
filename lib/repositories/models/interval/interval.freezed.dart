// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interval.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

IntervalType _$IntervalTypeFromJson(Map<String, dynamic> json) {
  return _Interval.fromJson(json);
}

/// @nodoc
mixin _$IntervalType {
  int get days => throw _privateConstructorUsedError;
  int get hours => throw _privateConstructorUsedError;
  int get minutes => throw _privateConstructorUsedError;
  int get seconds => throw _privateConstructorUsedError;
  int get milliseconds => throw _privateConstructorUsedError;
  int get ticks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $IntervalTypeCopyWith<IntervalType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $IntervalTypeCopyWith<$Res> {
  factory $IntervalTypeCopyWith(
          IntervalType value, $Res Function(IntervalType) then) =
      _$IntervalTypeCopyWithImpl<$Res, IntervalType>;
  @useResult
  $Res call(
      {int days,
      int hours,
      int minutes,
      int seconds,
      int milliseconds,
      int ticks});
}

/// @nodoc
class _$IntervalTypeCopyWithImpl<$Res, $Val extends IntervalType>
    implements $IntervalTypeCopyWith<$Res> {
  _$IntervalTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
    Object? hours = null,
    Object? minutes = null,
    Object? seconds = null,
    Object? milliseconds = null,
    Object? ticks = null,
  }) {
    return _then(_value.copyWith(
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as int,
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int,
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      seconds: null == seconds
          ? _value.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int,
      milliseconds: null == milliseconds
          ? _value.milliseconds
          : milliseconds // ignore: cast_nullable_to_non_nullable
              as int,
      ticks: null == ticks
          ? _value.ticks
          : ticks // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$IntervalImplCopyWith<$Res>
    implements $IntervalTypeCopyWith<$Res> {
  factory _$$IntervalImplCopyWith(
          _$IntervalImpl value, $Res Function(_$IntervalImpl) then) =
      __$$IntervalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int days,
      int hours,
      int minutes,
      int seconds,
      int milliseconds,
      int ticks});
}

/// @nodoc
class __$$IntervalImplCopyWithImpl<$Res>
    extends _$IntervalTypeCopyWithImpl<$Res, _$IntervalImpl>
    implements _$$IntervalImplCopyWith<$Res> {
  __$$IntervalImplCopyWithImpl(
      _$IntervalImpl _value, $Res Function(_$IntervalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? days = null,
    Object? hours = null,
    Object? minutes = null,
    Object? seconds = null,
    Object? milliseconds = null,
    Object? ticks = null,
  }) {
    return _then(_$IntervalImpl(
      days: null == days
          ? _value.days
          : days // ignore: cast_nullable_to_non_nullable
              as int,
      hours: null == hours
          ? _value.hours
          : hours // ignore: cast_nullable_to_non_nullable
              as int,
      minutes: null == minutes
          ? _value.minutes
          : minutes // ignore: cast_nullable_to_non_nullable
              as int,
      seconds: null == seconds
          ? _value.seconds
          : seconds // ignore: cast_nullable_to_non_nullable
              as int,
      milliseconds: null == milliseconds
          ? _value.milliseconds
          : milliseconds // ignore: cast_nullable_to_non_nullable
              as int,
      ticks: null == ticks
          ? _value.ticks
          : ticks // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$IntervalImpl extends _Interval {
  const _$IntervalImpl(
      {this.days = 0,
      this.hours = 0,
      this.minutes = 0,
      this.seconds = 0,
      this.milliseconds = 0,
      this.ticks = 0})
      : super._();

  factory _$IntervalImpl.fromJson(Map<String, dynamic> json) =>
      _$$IntervalImplFromJson(json);

  @override
  @JsonKey()
  final int days;
  @override
  @JsonKey()
  final int hours;
  @override
  @JsonKey()
  final int minutes;
  @override
  @JsonKey()
  final int seconds;
  @override
  @JsonKey()
  final int milliseconds;
  @override
  @JsonKey()
  final int ticks;

  @override
  String toString() {
    return 'IntervalType(days: $days, hours: $hours, minutes: $minutes, seconds: $seconds, milliseconds: $milliseconds, ticks: $ticks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IntervalImpl &&
            (identical(other.days, days) || other.days == days) &&
            (identical(other.hours, hours) || other.hours == hours) &&
            (identical(other.minutes, minutes) || other.minutes == minutes) &&
            (identical(other.seconds, seconds) || other.seconds == seconds) &&
            (identical(other.milliseconds, milliseconds) ||
                other.milliseconds == milliseconds) &&
            (identical(other.ticks, ticks) || other.ticks == ticks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, days, hours, minutes, seconds, milliseconds, ticks);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IntervalImplCopyWith<_$IntervalImpl> get copyWith =>
      __$$IntervalImplCopyWithImpl<_$IntervalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$IntervalImplToJson(
      this,
    );
  }
}

abstract class _Interval extends IntervalType {
  const factory _Interval(
      {final int days,
      final int hours,
      final int minutes,
      final int seconds,
      final int milliseconds,
      final int ticks}) = _$IntervalImpl;
  const _Interval._() : super._();

  factory _Interval.fromJson(Map<String, dynamic> json) =
      _$IntervalImpl.fromJson;

  @override
  int get days;
  @override
  int get hours;
  @override
  int get minutes;
  @override
  int get seconds;
  @override
  int get milliseconds;
  @override
  int get ticks;
  @override
  @JsonKey(ignore: true)
  _$$IntervalImplCopyWith<_$IntervalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
