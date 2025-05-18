import 'package:preview_play/src/features/data/api/messages_api.dart';
import 'package:preview_play/src/features/data/models/message_model.dart';
import 'package:preview_play/src/features/domain/repositories/message_repository.dart';

import '../models/daily_question_model.dart';

class MessagesRepositoryImpl implements MessagesRepository {
  final MessagesApi messageApi;

  MessagesRepositoryImpl({required this.messageApi});

  @override
  Future<List<MessageModel>?> fetchMessages(String conversationId) async {
    return await messageApi.fetchMessages(conversationId);
  }

  @override
  Future<void> sendMessage(MessageModel message) {
    throw UnimplementedError();
  }

  @override
  Future<DailyQuestionModel?> fetchDailyQuestion(String conversationId) async {
    return await messageApi.fetchDailyQuestion(conversationId);
  }
}
