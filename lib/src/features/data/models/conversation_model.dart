import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_model.freezed.dart';
part 'conversation_model.g.dart';

@freezed
class ConversationModel with _$ConversationModel {
  const factory ConversationModel({
    @JsonKey(name: 'conversation_id') required String id,
    @JsonKey(name: 'participant_name') required String participantName,
    @JsonKey(name: 'participant_image')
    @Default('https://robohash.org/flutterdev?set=set3&size=200x200')
    String participantImage,
    @JsonKey(name: 'last_message') String? lastMessage,
    @JsonKey(name: 'last_message_time')
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime? lastMessageTime,
  }) = _ConversationModel;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);
}

DateTime _dateTimeFromJson(dynamic value) {
  if (value == null) return DateTime.now();
  return DateTime.parse(value.toString());
}

String _dateTimeToJson(DateTime dateTime) => dateTime.toIso8601String();
