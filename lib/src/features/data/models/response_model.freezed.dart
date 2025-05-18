// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ResponseModel<T> _$ResponseModelFromJson<T>(Map<String, dynamic> json) {
  return _ResponseModel<T>.fromJson(json);
}

/// @nodoc
mixin _$ResponseModel<T> {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Object? get result => throw _privateConstructorUsedError;

  /// Serializes this ResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ResponseModelCopyWith<T, ResponseModel<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResponseModelCopyWith<T, $Res> {
  factory $ResponseModelCopyWith(
    ResponseModel<T> value,
    $Res Function(ResponseModel<T>) then,
  ) = _$ResponseModelCopyWithImpl<T, $Res, ResponseModel<T>>;
  @useResult
  $Res call({int code, String message, Object? result});
}

/// @nodoc
class _$ResponseModelCopyWithImpl<T, $Res, $Val extends ResponseModel<T>>
    implements $ResponseModelCopyWith<T, $Res> {
  _$ResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? result = freezed,
  }) {
    return _then(
      _value.copyWith(
            code:
                null == code
                    ? _value.code
                    : code // ignore: cast_nullable_to_non_nullable
                        as int,
            message:
                null == message
                    ? _value.message
                    : message // ignore: cast_nullable_to_non_nullable
                        as String,
            result: freezed == result ? _value.result : result,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ResponseModelImplCopyWith<T, $Res>
    implements $ResponseModelCopyWith<T, $Res> {
  factory _$$ResponseModelImplCopyWith(
    _$ResponseModelImpl<T> value,
    $Res Function(_$ResponseModelImpl<T>) then,
  ) = __$$ResponseModelImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({int code, String message, Object? result});
}

/// @nodoc
class __$$ResponseModelImplCopyWithImpl<T, $Res>
    extends _$ResponseModelCopyWithImpl<T, $Res, _$ResponseModelImpl<T>>
    implements _$$ResponseModelImplCopyWith<T, $Res> {
  __$$ResponseModelImplCopyWithImpl(
    _$ResponseModelImpl<T> _value,
    $Res Function(_$ResponseModelImpl<T>) _then,
  ) : super(_value, _then);

  /// Create a copy of ResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? result = freezed,
  }) {
    return _then(
      _$ResponseModelImpl<T>(
        code:
            null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                    as int,
        message:
            null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                    as String,
        result: freezed == result ? _value.result : result,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ResponseModelImpl<T> implements _ResponseModel<T> {
  const _$ResponseModelImpl({
    required this.code,
    required this.message,
    required this.result,
  });

  factory _$ResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ResponseModelImplFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final Object? result;

  @override
  String toString() {
    return 'ResponseModel<$T>(code: $code, message: $message, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ResponseModelImpl<T> &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    message,
    const DeepCollectionEquality().hash(result),
  );

  /// Create a copy of ResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ResponseModelImplCopyWith<T, _$ResponseModelImpl<T>> get copyWith =>
      __$$ResponseModelImplCopyWithImpl<T, _$ResponseModelImpl<T>>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ResponseModelImplToJson<T>(this);
  }
}

abstract class _ResponseModel<T> implements ResponseModel<T> {
  const factory _ResponseModel({
    required final int code,
    required final String message,
    required final Object? result,
  }) = _$ResponseModelImpl<T>;

  factory _ResponseModel.fromJson(Map<String, dynamic> json) =
      _$ResponseModelImpl<T>.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  Object? get result;

  /// Create a copy of ResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ResponseModelImplCopyWith<T, _$ResponseModelImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}
