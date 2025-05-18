// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoticeResponseImpl _$$NoticeResponseImplFromJson(Map<String, dynamic> json) =>
    _$NoticeResponseImpl(
      code: (json['code'] as num).toInt(),
      pagination: Pagination.fromJson(
        json['pagination'] as Map<String, dynamic>,
      ),
      noticeList:
          (json['notice_list'] as List<dynamic>)
              .map((e) => NoticeModel.fromJson(e as Map<String, dynamic>))
              .toList(),
    );

Map<String, dynamic> _$$NoticeResponseImplToJson(
  _$NoticeResponseImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'pagination': instance.pagination,
  'notice_list': instance.noticeList,
};

_$PaginationImpl _$$PaginationImplFromJson(Map<String, dynamic> json) =>
    _$PaginationImpl(
      index: (json['index'] as num).toInt(),
      limit: (json['limit'] as num).toInt(),
      total: (json['total'] as num).toInt(),
    );

Map<String, dynamic> _$$PaginationImplToJson(_$PaginationImpl instance) =>
    <String, dynamic>{
      'index': instance.index,
      'limit': instance.limit,
      'total': instance.total,
    };

_$NoticeModelImpl _$$NoticeModelImplFromJson(Map<String, dynamic> json) =>
    _$NoticeModelImpl(
      id: (json['id'] as num).toInt(),
      to: (json['to'] as num?)?.toInt(),
      noticeAt: (json['notice_at'] as num).toInt(),
      title: json['title'] as String,
      brief: json['brief'] as String,
    );

Map<String, dynamic> _$$NoticeModelImplToJson(_$NoticeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'to': instance.to,
      'notice_at': instance.noticeAt,
      'title': instance.title,
      'brief': instance.brief,
    };
