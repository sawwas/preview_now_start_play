// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'contacts_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ContactsModel _$ContactsModelFromJson(Map<String, dynamic> json) {
  return _ContactsModel.fromJson(json);
}

/// @nodoc
mixin _$ContactsModel {
  @JsonKey(name: 'contact_id')
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'profile_image')
  String get profileImage => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_id')
  String? get conversationId => throw _privateConstructorUsedError;

  /// Serializes this ContactsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContactsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactsModelCopyWith<ContactsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactsModelCopyWith<$Res> {
  factory $ContactsModelCopyWith(
    ContactsModel value,
    $Res Function(ContactsModel) then,
  ) = _$ContactsModelCopyWithImpl<$Res, ContactsModel>;
  @useResult
  $Res call({
    @JsonKey(name: 'contact_id') String id,
    String username,
    @JsonKey(name: 'profile_image') String profileImage,
    String email,
    @JsonKey(name: 'conversation_id') String? conversationId,
  });
}

/// @nodoc
class _$ContactsModelCopyWithImpl<$Res, $Val extends ContactsModel>
    implements $ContactsModelCopyWith<$Res> {
  _$ContactsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? profileImage = null,
    Object? email = null,
    Object? conversationId = freezed,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            username:
                null == username
                    ? _value.username
                    : username // ignore: cast_nullable_to_non_nullable
                        as String,
            profileImage:
                null == profileImage
                    ? _value.profileImage
                    : profileImage // ignore: cast_nullable_to_non_nullable
                        as String,
            email:
                null == email
                    ? _value.email
                    : email // ignore: cast_nullable_to_non_nullable
                        as String,
            conversationId:
                freezed == conversationId
                    ? _value.conversationId
                    : conversationId // ignore: cast_nullable_to_non_nullable
                        as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContactsModelImplCopyWith<$Res>
    implements $ContactsModelCopyWith<$Res> {
  factory _$$ContactsModelImplCopyWith(
    _$ContactsModelImpl value,
    $Res Function(_$ContactsModelImpl) then,
  ) = __$$ContactsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'contact_id') String id,
    String username,
    @JsonKey(name: 'profile_image') String profileImage,
    String email,
    @JsonKey(name: 'conversation_id') String? conversationId,
  });
}

/// @nodoc
class __$$ContactsModelImplCopyWithImpl<$Res>
    extends _$ContactsModelCopyWithImpl<$Res, _$ContactsModelImpl>
    implements _$$ContactsModelImplCopyWith<$Res> {
  __$$ContactsModelImplCopyWithImpl(
    _$ContactsModelImpl _value,
    $Res Function(_$ContactsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? profileImage = null,
    Object? email = null,
    Object? conversationId = freezed,
  }) {
    return _then(
      _$ContactsModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        username:
            null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                    as String,
        profileImage:
            null == profileImage
                ? _value.profileImage
                : profileImage // ignore: cast_nullable_to_non_nullable
                    as String,
        email:
            null == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                    as String,
        conversationId:
            freezed == conversationId
                ? _value.conversationId
                : conversationId // ignore: cast_nullable_to_non_nullable
                    as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactsModelImpl implements _ContactsModel {
  const _$ContactsModelImpl({
    @JsonKey(name: 'contact_id') required this.id,
    required this.username,
    @JsonKey(name: 'profile_image')
    this.profileImage = 'https://robohash.org/flutterdev?set=set3&size=200x200',
    required this.email,
    @JsonKey(name: 'conversation_id') this.conversationId,
  });

  factory _$ContactsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactsModelImplFromJson(json);

  @override
  @JsonKey(name: 'contact_id')
  final String id;
  @override
  final String username;
  @override
  @JsonKey(name: 'profile_image')
  final String profileImage;
  @override
  final String email;
  @override
  @JsonKey(name: 'conversation_id')
  final String? conversationId;

  @override
  String toString() {
    return 'ContactsModel(id: $id, username: $username, profileImage: $profileImage, email: $email, conversationId: $conversationId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.profileImage, profileImage) ||
                other.profileImage == profileImage) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.conversationId, conversationId) ||
                other.conversationId == conversationId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    username,
    profileImage,
    email,
    conversationId,
  );

  /// Create a copy of ContactsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactsModelImplCopyWith<_$ContactsModelImpl> get copyWith =>
      __$$ContactsModelImplCopyWithImpl<_$ContactsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactsModelImplToJson(this);
  }
}

abstract class _ContactsModel implements ContactsModel {
  const factory _ContactsModel({
    @JsonKey(name: 'contact_id') required final String id,
    required final String username,
    @JsonKey(name: 'profile_image') final String profileImage,
    required final String email,
    @JsonKey(name: 'conversation_id') final String? conversationId,
  }) = _$ContactsModelImpl;

  factory _ContactsModel.fromJson(Map<String, dynamic> json) =
      _$ContactsModelImpl.fromJson;

  @override
  @JsonKey(name: 'contact_id')
  String get id;
  @override
  String get username;
  @override
  @JsonKey(name: 'profile_image')
  String get profileImage;
  @override
  String get email;
  @override
  @JsonKey(name: 'conversation_id')
  String? get conversationId;

  /// Create a copy of ContactsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactsModelImplCopyWith<_$ContactsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
