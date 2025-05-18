import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/conversation_model.dart';
import 'app_api.dart';

class ConversationsApi {
  final _storage = FlutterSecureStorage();

  ConversationsApi();

  Future<List<ConversationModel>?> fetchConversations() async {
    final response = await AppApi().get('conversations');
    if (response != null) {
      List data = response;

      List<ConversationModel> conversations = [];
      for (var item in data) {
        conversations.add(
          ConversationModel.fromJson(item as Map<String, dynamic>),
        );
      }
      return conversations;
    } else {
      throw Exception('Failed to fetch conversations');
    }
  }

  Future<String?> checkOrCreateConversation({required String contactId}) async {
    String token = await _storage.read(key: 'token') ?? '';

    final response = await AppApi().post(
      'conversations/check-or-create',
      data: {'contactId': contactId},
    );
    if (response != null) {
      return response['conversationId'];
    } else {
      throw Exception('Failed to check or create conversations');
    }
  }
}
