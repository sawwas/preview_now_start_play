import 'package:preview_play/src/features/data/api/conversations_api.dart';
import 'package:preview_play/src/features/data/models/conversation_model.dart';

import '../../domain/repositories/conversations_repository.dart';

class ConversationsRepositoryImpl implements ConversationsRepository {
  final ConversationsApi conversationApi;

  ConversationsRepositoryImpl({required this.conversationApi});

  @override
  Future<List<ConversationModel>?> fetchConversations() async {
    return await conversationApi.fetchConversations();
  }

  @override
  Future<String?> checkOrCreateConversation({required String contactId}) async {
    return await conversationApi.checkOrCreateConversation(
      contactId: contactId,
    );
  }
}
