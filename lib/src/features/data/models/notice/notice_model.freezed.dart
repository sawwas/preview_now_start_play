// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NoticeResponse _$NoticeResponseFromJson(Map<String, dynamic> json) {
  return _NoticeResponse.fromJson(json);
}

/// @nodoc
mixin _$NoticeResponse {
  int get code => throw _privateConstructorUsedError;
  Pagination get pagination => throw _privateConstructorUsedError;
  @JsonKey(name: 'notice_list')
  List<NoticeModel> get noticeList => throw _privateConstructorUsedError;

  /// Serializes this NoticeResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeResponseCopyWith<NoticeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeResponseCopyWith<$Res> {
  factory $NoticeResponseCopyWith(
    NoticeResponse value,
    $Res Function(NoticeResponse) then,
  ) = _$NoticeResponseCopyWithImpl<$Res, NoticeResponse>;
  @useResult
  $Res call({
    int code,
    Pagination pagination,
    @JsonKey(name: 'notice_list') List<NoticeModel> noticeList,
  });

  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class _$NoticeResponseCopyWithImpl<$Res, $Val extends NoticeResponse>
    implements $NoticeResponseCopyWith<$Res> {
  _$NoticeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? pagination = null,
    Object? noticeList = null,
  }) {
    return _then(
      _value.copyWith(
            code:
                null == code
                    ? _value.code
                    : code // ignore: cast_nullable_to_non_nullable
                        as int,
            pagination:
                null == pagination
                    ? _value.pagination
                    : pagination // ignore: cast_nullable_to_non_nullable
                        as Pagination,
            noticeList:
                null == noticeList
                    ? _value.noticeList
                    : noticeList // ignore: cast_nullable_to_non_nullable
                        as List<NoticeModel>,
          )
          as $Val,
    );
  }

  /// Create a copy of NoticeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PaginationCopyWith<$Res> get pagination {
    return $PaginationCopyWith<$Res>(_value.pagination, (value) {
      return _then(_value.copyWith(pagination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NoticeResponseImplCopyWith<$Res>
    implements $NoticeResponseCopyWith<$Res> {
  factory _$$NoticeResponseImplCopyWith(
    _$NoticeResponseImpl value,
    $Res Function(_$NoticeResponseImpl) then,
  ) = __$$NoticeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int code,
    Pagination pagination,
    @JsonKey(name: 'notice_list') List<NoticeModel> noticeList,
  });

  @override
  $PaginationCopyWith<$Res> get pagination;
}

/// @nodoc
class __$$NoticeResponseImplCopyWithImpl<$Res>
    extends _$NoticeResponseCopyWithImpl<$Res, _$NoticeResponseImpl>
    implements _$$NoticeResponseImplCopyWith<$Res> {
  __$$NoticeResponseImplCopyWithImpl(
    _$NoticeResponseImpl _value,
    $Res Function(_$NoticeResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NoticeResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? pagination = null,
    Object? noticeList = null,
  }) {
    return _then(
      _$NoticeResponseImpl(
        code:
            null == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                    as int,
        pagination:
            null == pagination
                ? _value.pagination
                : pagination // ignore: cast_nullable_to_non_nullable
                    as Pagination,
        noticeList:
            null == noticeList
                ? _value._noticeList
                : noticeList // ignore: cast_nullable_to_non_nullable
                    as List<NoticeModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NoticeResponseImpl implements _NoticeResponse {
  const _$NoticeResponseImpl({
    required this.code,
    required this.pagination,
    @JsonKey(name: 'notice_list') required final List<NoticeModel> noticeList,
  }) : _noticeList = noticeList;

  factory _$NoticeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeResponseImplFromJson(json);

  @override
  final int code;
  @override
  final Pagination pagination;
  final List<NoticeModel> _noticeList;
  @override
  @JsonKey(name: 'notice_list')
  List<NoticeModel> get noticeList {
    if (_noticeList is EqualUnmodifiableListView) return _noticeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_noticeList);
  }

  @override
  String toString() {
    return 'NoticeResponse(code: $code, pagination: $pagination, noticeList: $noticeList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeResponseImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.pagination, pagination) ||
                other.pagination == pagination) &&
            const DeepCollectionEquality().equals(
              other._noticeList,
              _noticeList,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    pagination,
    const DeepCollectionEquality().hash(_noticeList),
  );

  /// Create a copy of NoticeResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeResponseImplCopyWith<_$NoticeResponseImpl> get copyWith =>
      __$$NoticeResponseImplCopyWithImpl<_$NoticeResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeResponseImplToJson(this);
  }
}

abstract class _NoticeResponse implements NoticeResponse {
  const factory _NoticeResponse({
    required final int code,
    required final Pagination pagination,
    @JsonKey(name: 'notice_list') required final List<NoticeModel> noticeList,
  }) = _$NoticeResponseImpl;

  factory _NoticeResponse.fromJson(Map<String, dynamic> json) =
      _$NoticeResponseImpl.fromJson;

  @override
  int get code;
  @override
  Pagination get pagination;
  @override
  @JsonKey(name: 'notice_list')
  List<NoticeModel> get noticeList;

  /// Create a copy of NoticeResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeResponseImplCopyWith<_$NoticeResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Pagination _$PaginationFromJson(Map<String, dynamic> json) {
  return _Pagination.fromJson(json);
}

/// @nodoc
mixin _$Pagination {
  int get index => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this Pagination to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginationCopyWith<Pagination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginationCopyWith<$Res> {
  factory $PaginationCopyWith(
    Pagination value,
    $Res Function(Pagination) then,
  ) = _$PaginationCopyWithImpl<$Res, Pagination>;
  @useResult
  $Res call({int index, int limit, int total});
}

/// @nodoc
class _$PaginationCopyWithImpl<$Res, $Val extends Pagination>
    implements $PaginationCopyWith<$Res> {
  _$PaginationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? limit = null,
    Object? total = null,
  }) {
    return _then(
      _value.copyWith(
            index:
                null == index
                    ? _value.index
                    : index // ignore: cast_nullable_to_non_nullable
                        as int,
            limit:
                null == limit
                    ? _value.limit
                    : limit // ignore: cast_nullable_to_non_nullable
                        as int,
            total:
                null == total
                    ? _value.total
                    : total // ignore: cast_nullable_to_non_nullable
                        as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginationImplCopyWith<$Res>
    implements $PaginationCopyWith<$Res> {
  factory _$$PaginationImplCopyWith(
    _$PaginationImpl value,
    $Res Function(_$PaginationImpl) then,
  ) = __$$PaginationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int index, int limit, int total});
}

/// @nodoc
class __$$PaginationImplCopyWithImpl<$Res>
    extends _$PaginationCopyWithImpl<$Res, _$PaginationImpl>
    implements _$$PaginationImplCopyWith<$Res> {
  __$$PaginationImplCopyWithImpl(
    _$PaginationImpl _value,
    $Res Function(_$PaginationImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? index = null,
    Object? limit = null,
    Object? total = null,
  }) {
    return _then(
      _$PaginationImpl(
        index:
            null == index
                ? _value.index
                : index // ignore: cast_nullable_to_non_nullable
                    as int,
        limit:
            null == limit
                ? _value.limit
                : limit // ignore: cast_nullable_to_non_nullable
                    as int,
        total:
            null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                    as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginationImpl implements _Pagination {
  const _$PaginationImpl({
    required this.index,
    required this.limit,
    required this.total,
  });

  factory _$PaginationImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginationImplFromJson(json);

  @override
  final int index;
  @override
  final int limit;
  @override
  final int total;

  @override
  String toString() {
    return 'Pagination(index: $index, limit: $limit, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginationImpl &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.limit, limit) || other.limit == limit) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, index, limit, total);

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginationImplCopyWith<_$PaginationImpl> get copyWith =>
      __$$PaginationImplCopyWithImpl<_$PaginationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginationImplToJson(this);
  }
}

abstract class _Pagination implements Pagination {
  const factory _Pagination({
    required final int index,
    required final int limit,
    required final int total,
  }) = _$PaginationImpl;

  factory _Pagination.fromJson(Map<String, dynamic> json) =
      _$PaginationImpl.fromJson;

  @override
  int get index;
  @override
  int get limit;
  @override
  int get total;

  /// Create a copy of Pagination
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginationImplCopyWith<_$PaginationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoticeModel _$NoticeModelFromJson(Map<String, dynamic> json) {
  return _NoticeModel.fromJson(json);
}

/// @nodoc
mixin _$NoticeModel {
  int get id => throw _privateConstructorUsedError;
  int? get to => throw _privateConstructorUsedError;
  @JsonKey(name: 'notice_at')
  int get noticeAt => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get brief => throw _privateConstructorUsedError;

  /// Serializes this NoticeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeModelCopyWith<NoticeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeModelCopyWith<$Res> {
  factory $NoticeModelCopyWith(
    NoticeModel value,
    $Res Function(NoticeModel) then,
  ) = _$NoticeModelCopyWithImpl<$Res, NoticeModel>;
  @useResult
  $Res call({
    int id,
    int? to,
    @JsonKey(name: 'notice_at') int noticeAt,
    String title,
    String brief,
  });
}

/// @nodoc
class _$NoticeModelCopyWithImpl<$Res, $Val extends NoticeModel>
    implements $NoticeModelCopyWith<$Res> {
  _$NoticeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? to = freezed,
    Object? noticeAt = null,
    Object? title = null,
    Object? brief = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as int,
            to:
                freezed == to
                    ? _value.to
                    : to // ignore: cast_nullable_to_non_nullable
                        as int?,
            noticeAt:
                null == noticeAt
                    ? _value.noticeAt
                    : noticeAt // ignore: cast_nullable_to_non_nullable
                        as int,
            title:
                null == title
                    ? _value.title
                    : title // ignore: cast_nullable_to_non_nullable
                        as String,
            brief:
                null == brief
                    ? _value.brief
                    : brief // ignore: cast_nullable_to_non_nullable
                        as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NoticeModelImplCopyWith<$Res>
    implements $NoticeModelCopyWith<$Res> {
  factory _$$NoticeModelImplCopyWith(
    _$NoticeModelImpl value,
    $Res Function(_$NoticeModelImpl) then,
  ) = __$$NoticeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    int? to,
    @JsonKey(name: 'notice_at') int noticeAt,
    String title,
    String brief,
  });
}

/// @nodoc
class __$$NoticeModelImplCopyWithImpl<$Res>
    extends _$NoticeModelCopyWithImpl<$Res, _$NoticeModelImpl>
    implements _$$NoticeModelImplCopyWith<$Res> {
  __$$NoticeModelImplCopyWithImpl(
    _$NoticeModelImpl _value,
    $Res Function(_$NoticeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NoticeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? to = freezed,
    Object? noticeAt = null,
    Object? title = null,
    Object? brief = null,
  }) {
    return _then(
      _$NoticeModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as int,
        to:
            freezed == to
                ? _value.to
                : to // ignore: cast_nullable_to_non_nullable
                    as int?,
        noticeAt:
            null == noticeAt
                ? _value.noticeAt
                : noticeAt // ignore: cast_nullable_to_non_nullable
                    as int,
        title:
            null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                    as String,
        brief:
            null == brief
                ? _value.brief
                : brief // ignore: cast_nullable_to_non_nullable
                    as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NoticeModelImpl implements _NoticeModel {
  const _$NoticeModelImpl({
    required this.id,
    this.to,
    @JsonKey(name: 'notice_at') required this.noticeAt,
    required this.title,
    required this.brief,
  });

  factory _$NoticeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeModelImplFromJson(json);

  @override
  final int id;
  @override
  final int? to;
  @override
  @JsonKey(name: 'notice_at')
  final int noticeAt;
  @override
  final String title;
  @override
  final String brief;

  @override
  String toString() {
    return 'NoticeModel(id: $id, to: $to, noticeAt: $noticeAt, title: $title, brief: $brief)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.to, to) || other.to == to) &&
            (identical(other.noticeAt, noticeAt) ||
                other.noticeAt == noticeAt) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.brief, brief) || other.brief == brief));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, to, noticeAt, title, brief);

  /// Create a copy of NoticeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeModelImplCopyWith<_$NoticeModelImpl> get copyWith =>
      __$$NoticeModelImplCopyWithImpl<_$NoticeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeModelImplToJson(this);
  }
}

abstract class _NoticeModel implements NoticeModel {
  const factory _NoticeModel({
    required final int id,
    final int? to,
    @JsonKey(name: 'notice_at') required final int noticeAt,
    required final String title,
    required final String brief,
  }) = _$NoticeModelImpl;

  factory _NoticeModel.fromJson(Map<String, dynamic> json) =
      _$NoticeModelImpl.fromJson;

  @override
  int get id;
  @override
  int? get to;
  @override
  @JsonKey(name: 'notice_at')
  int get noticeAt;
  @override
  String get title;
  @override
  String get brief;

  /// Create a copy of NoticeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeModelImplCopyWith<_$NoticeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
