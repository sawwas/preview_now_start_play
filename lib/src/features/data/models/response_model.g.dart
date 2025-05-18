// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ResponseModelImpl<T> _$$ResponseModelImplFromJson<T>(
  Map<String, dynamic> json,
) => _$ResponseModelImpl<T>(
  code: (json['code'] as num).toInt(),
  message: json['message'] as String,
  result: json['result'],
);

Map<String, dynamic> _$$ResponseModelImplToJson<T>(
  _$ResponseModelImpl<T> instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'result': instance.result,
};
