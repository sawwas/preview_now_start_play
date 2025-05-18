import 'package:preview_play/src/features/data/api/app_api.dart';

import '../models/daily_question_model.dart';
import '../models/message_model.dart';

class MessagesApi {
  MessagesApi();

  Future<List<MessageModel>?> fetchMessages(String conversationId) async {
    final response = await AppApi().get('messages/$conversationId');

    if (response != null) {
      List data = response;
      List<MessageModel> messages = [];
      for (var item in data) {
        messages.add(MessageModel.fromJson(item as Map<String, dynamic>));
      }
      return messages;
    } else {
      throw Exception('Failed to fetch Messages');
    }
  }

  Future<DailyQuestionModel> fetchDailyQuestion(String conversationId) async {
    final response = await AppApi().get(
      'conversations/$conversationId/daily-question',
    );

    if (response != null) {
      return DailyQuestionModel.fromJson(response);
    } else {
      throw Exception('Failed to fetch daily question');
    }
  }
}
