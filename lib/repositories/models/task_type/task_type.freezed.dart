// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskType _$TaskTypeFromJson(Map<String, dynamic> json) {
  return _TaskType.fromJson(json);
}

/// @nodoc
mixin _$TaskType {
  int get type => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskTypeCopyWith<TaskType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskTypeCopyWith<$Res> {
  factory $TaskTypeCopyWith(TaskType value, $Res Function(TaskType) then) =
      _$TaskTypeCopyWithImpl<$Res, TaskType>;
  @useResult
  $Res call({int type});
}

/// @nodoc
class _$TaskTypeCopyWithImpl<$Res, $Val extends TaskType>
    implements $TaskTypeCopyWith<$Res> {
  _$TaskTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskTypeImplCopyWith<$Res>
    implements $TaskTypeCopyWith<$Res> {
  factory _$$TaskTypeImplCopyWith(
          _$TaskTypeImpl value, $Res Function(_$TaskTypeImpl) then) =
      __$$TaskTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int type});
}

/// @nodoc
class __$$TaskTypeImplCopyWithImpl<$Res>
    extends _$TaskTypeCopyWithImpl<$Res, _$TaskTypeImpl>
    implements _$$TaskTypeImplCopyWith<$Res> {
  __$$TaskTypeImplCopyWithImpl(
      _$TaskTypeImpl _value, $Res Function(_$TaskTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
  }) {
    return _then(_$TaskTypeImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskTypeImpl extends _TaskType {
  _$TaskTypeImpl({required this.type}) : super._();

  factory _$TaskTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskTypeImplFromJson(json);

  @override
  final int type;

  @override
  String toString() {
    return 'TaskType(type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskTypeImpl &&
            (identical(other.type, type) || other.type == type));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskTypeImplCopyWith<_$TaskTypeImpl> get copyWith =>
      __$$TaskTypeImplCopyWithImpl<_$TaskTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskTypeImplToJson(
      this,
    );
  }
}

abstract class _TaskType extends TaskType {
  factory _TaskType({required final int type}) = _$TaskTypeImpl;
  _TaskType._() : super._();

  factory _TaskType.fromJson(Map<String, dynamic> json) =
      _$TaskTypeImpl.fromJson;

  @override
  int get type;
  @override
  @JsonKey(ignore: true)
  _$$TaskTypeImplCopyWith<_$TaskTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
