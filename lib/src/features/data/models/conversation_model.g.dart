// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationModelImpl _$$ConversationModelImplFromJson(
  Map<String, dynamic> json,
) => _$ConversationModelImpl(
  id: json['conversation_id'] as String,
  participantName: json['participant_name'] as String,
  participantImage:
      json['participant_image'] as String? ??
      'https://robohash.org/flutterdev?set=set3&size=200x200',
  lastMessage: json['last_message'] as String?,
  lastMessageTime:
      json['last_message_time'] == null
          ? null
          : DateTime.parse(json['last_message_time'] as String),
);

Map<String, dynamic> _$$ConversationModelImplToJson(
  _$ConversationModelImpl instance,
) => <String, dynamic>{
  'conversation_id': instance.id,
  'participant_name': instance.participantName,
  'participant_image': instance.participantImage,
  'last_message': instance.lastMessage,
  'last_message_time': instance.lastMessageTime?.toIso8601String(),
};
