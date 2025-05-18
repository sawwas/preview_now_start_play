// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactsModelImpl _$$ContactsModelImplFromJson(Map<String, dynamic> json) =>
    _$ContactsModelImpl(
      id: json['contact_id'] as String,
      username: json['username'] as String,
      profileImage:
          json['profile_image'] as String? ??
          'https://robohash.org/flutterdev?set=set3&size=200x200',
      email: json['email'] as String,
      conversationId: json['conversation_id'] as String?,
    );

Map<String, dynamic> _$$ContactsModelImplToJson(_$ContactsModelImpl instance) =>
    <String, dynamic>{
      'contact_id': instance.id,
      'username': instance.username,
      'profile_image': instance.profileImage,
      'email': instance.email,
      'conversation_id': instance.conversationId,
    };
