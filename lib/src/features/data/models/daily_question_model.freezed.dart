// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_question_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailyQuestionModel _$DailyQuestionModelFromJson(Map<String, dynamic> json) {
  return _DailyQuestionModel.fromJson(json);
}

/// @nodoc
mixin _$DailyQuestionModel {
  String? get content => throw _privateConstructorUsedError;

  /// Serializes this DailyQuestionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyQuestionModelCopyWith<DailyQuestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyQuestionModelCopyWith<$Res> {
  factory $DailyQuestionModelCopyWith(
    DailyQuestionModel value,
    $Res Function(DailyQuestionModel) then,
  ) = _$DailyQuestionModelCopyWithImpl<$Res, DailyQuestionModel>;
  @useResult
  $Res call({String? content});
}

/// @nodoc
class _$DailyQuestionModelCopyWithImpl<$Res, $Val extends DailyQuestionModel>
    implements $DailyQuestionModelCopyWith<$Res> {
  _$DailyQuestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? content = freezed}) {
    return _then(
      _value.copyWith(
            content:
                freezed == content
                    ? _value.content
                    : content // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyQuestionModelImplCopyWith<$Res>
    implements $DailyQuestionModelCopyWith<$Res> {
  factory _$$DailyQuestionModelImplCopyWith(
    _$DailyQuestionModelImpl value,
    $Res Function(_$DailyQuestionModelImpl) then,
  ) = __$$DailyQuestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? content});
}

/// @nodoc
class __$$DailyQuestionModelImplCopyWithImpl<$Res>
    extends _$DailyQuestionModelCopyWithImpl<$Res, _$DailyQuestionModelImpl>
    implements _$$DailyQuestionModelImplCopyWith<$Res> {
  __$$DailyQuestionModelImplCopyWithImpl(
    _$DailyQuestionModelImpl _value,
    $Res Function(_$DailyQuestionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? content = freezed}) {
    return _then(
      _$DailyQuestionModelImpl(
        content:
            freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyQuestionModelImpl implements _DailyQuestionModel {
  const _$DailyQuestionModelImpl({required this.content});

  factory _$DailyQuestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyQuestionModelImplFromJson(json);

  @override
  final String? content;

  @override
  String toString() {
    return 'DailyQuestionModel(content: $content)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyQuestionModelImpl &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, content);

  /// Create a copy of DailyQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyQuestionModelImplCopyWith<_$DailyQuestionModelImpl> get copyWith =>
      __$$DailyQuestionModelImplCopyWithImpl<_$DailyQuestionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyQuestionModelImplToJson(this);
  }
}

abstract class _DailyQuestionModel implements DailyQuestionModel {
  const factory _DailyQuestionModel({required final String? content}) =
      _$DailyQuestionModelImpl;

  factory _DailyQuestionModel.fromJson(Map<String, dynamic> json) =
      _$DailyQuestionModelImpl.fromJson;

  @override
  String? get content;

  /// Create a copy of DailyQuestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyQuestionModelImplCopyWith<_$DailyQuestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
