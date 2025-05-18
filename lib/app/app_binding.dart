import 'package:get/get.dart';
import 'package:preview_play/src/features/presentation/getX/websocket_controller.dart';

import '../src/features/presentation/getX/auth_controller.dart';
import '../src/features/presentation/getX/chat_controller.dart';
import '../src/features/presentation/getX/contacts_controller.dart';
import '../src/features/presentation/getX/conversations_controller.dart';
import 'app.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppController());
    Get.lazyPut<AuthController>(() => AuthController(), fenix: true);
    Get.lazyPut<ChatController>(() => ChatController(), fenix: true);
    Get.lazyPut<ContactsController>(() => ContactsController(), fenix: true);
    Get.lazyPut<ConversationsController>(
      () => ConversationsController(),
      fenix: true,
    );
    Get.lazyPut<WebSocketController>(() => WebSocketController(), fenix: true);
  }
}
