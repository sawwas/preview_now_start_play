import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts_model.freezed.dart';
part 'contacts_model.g.dart';

@freezed
class ContactsModel with _$ContactsModel {
  const factory ContactsModel({
    @JsonKey(name: 'contact_id') required String id,
    required String username,
    @JsonKey(name: 'profile_image')
    @Default('https://robohash.org/flutterdev?set=set3&size=200x200')
    String profileImage,
    required String email,
    @JsonKey(name: 'conversation_id') String? conversationId,
  }) = _ContactsModel;

  factory ContactsModel.fromJson(Map<String, dynamic> json) =>
      _$ContactsModelFromJson(json);
}
