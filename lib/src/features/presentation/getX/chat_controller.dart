import 'package:get/get.dart';
import 'package:preview_play/src/features/data/models/daily_question_model.dart';
import 'package:preview_play/src/features/data/models/message_model.dart';
import 'package:preview_play/utils/logs.dart';

import '../../../../main.dart';
import '../../../../utils/network/http_util.dart';
import '../../data/repositories/message_repository_impl.dart';

class ChatController extends GetxController {
  final MessagesRepositoryImpl messagesRepositoryImpl = sl();

  // final SocketService _socketService = SocketService();

  final RxList<MessageModel> messages = <MessageModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final Rxn<DailyQuestionModel> dailyQuestion = Rxn<DailyQuestionModel>();

  ChatController();

  Future<void> loadMessages(String conversationId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final loadedMessages =
          await messagesRepositoryImpl.fetchMessages(conversationId) ?? [];
      messages.clear();
      messages.addAll(loadedMessages);

      // _socketService.socket.off('newMessage');
      // _socketService.socket.emit('joinConversation', conversationId);
      // _socketService.socket.on('newMessage', (data) {
      //   logger.i("step1 - receive : $data");
      //   receiveMessage(data);
      // });
    } catch (e) {
      error.value = 'Failed to load messages';
    } finally {
      Future.delayed(Duration(milliseconds: 100), () {
        isLoading.value = false;
      });
    }
  }

  Future<void> sendMessage(String conversationId, String content) async {
    String userId = app.controllerChange.currentUser.value?.id ?? '';
    logger.i('userId : $userId');

    final newMessage = {
      'conversationId': conversationId,
      'content': content,
      'senderId': userId,
    };
    // _socketService.socket.emit('sendMessage', newMessage);
  }

  void receiveMessage(dynamic messageData) {
    logger.i("step2 - receive event called");
    logger.i(messageData);

    final message = MessageModel(
      id: messageData['id'],
      conversationId: messageData['conversation_id'],
      senderId: messageData['sender_id'],
      content: messageData['content'],
      createdAt: messageData['created_at'],
    );

    messages.add(message);
  }

  Future<void> loadDailyQuestion(String conversationId) async {
    isLoading.value = true;
    error.value = '';

    try {
      final question = await messagesRepositoryImpl.fetchDailyQuestion(
        conversationId,
      );
      dailyQuestion.value = question;
    } catch (e) {
      error.value = 'Failed to load Daily question';
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    // _socketService.socket.off('newMessage');
    super.onClose();
  }
}
