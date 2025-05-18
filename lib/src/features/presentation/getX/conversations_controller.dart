import 'package:get/get.dart';
import 'package:preview_play/src/features/data/models/conversation_model.dart';
import 'package:preview_play/src/features/data/repositories/conversations_repository_impl.dart';

import '../../../../utils/logs.dart';
import '../../../../utils/network/http_util.dart';

class ConversationsController extends GetxController {
  ConversationsController();

  // final SocketService _socketService = SocketService();

  // final Rx<bool?> isLoading = Rx<bool?>(null);
  final isLoading = false.obs;
  final conversations = <ConversationModel>[].obs;
  final errorMessage = ''.obs;

  final ConversationsRepositoryImpl conversationsRemoteDataAPI = sl();

  @override
  void onInit() {
    super.onInit();
    _initializeSocketListeners();
    fetchConversations();
  }

  void _initializeSocketListeners() {
    try {
      // _socketService.socket.on('conversationUpdated', (obs) {
      //   logger.i('obs: $obs');
      //   final index = conversations.indexWhere(
      //     (conv) => conv.id == obs['conversationId'],
      //   );
      //   if (index != -1) {
      //     conversations.value[index] = conversations.value[index].copyWith(
      //       lastMessage: obs['lastMessage'],
      //       lastMessageTime: DateTime.parse(obs['lastMessageTime']),
      //     );
      //     update([(conversations.value[index].id)]);
      //   } else {
      //     fetchConversations();
      //   }
      // });
    } catch (e) {
      logger.i("Error initializing socket listeners: $e");
    }
  }

  Future<void> fetchConversations() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result =
          await conversationsRemoteDataAPI.fetchConversations() ?? [];
      conversations.assignAll(result);
      refresh();
    } catch (e) {
      errorMessage.value = 'Failed to load conversations';
    } finally {
      isLoading.value = false;
    }
  }
}
