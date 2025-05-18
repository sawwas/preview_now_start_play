import 'package:preview_play/src/features/data/models/message_model.dart';

import '../../data/models/daily_question_model.dart';

abstract class MessagesRepository {
  Future<List<MessageModel>?> fetchMessages(String conversationId);

  Future<void> sendMessage(MessageModel message);

  Future<DailyQuestionModel?> fetchDailyQuestion(String conversationId);
}
