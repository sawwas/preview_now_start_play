import 'package:preview_play/src/features/data/models/conversation_model.dart';

abstract class ConversationsRepository {
  Future<List<ConversationModel>?> fetchConversations();

  Future<String?> checkOrCreateConversation({required String contactId});
}
