import 'package:navigation_history_observer/navigation_history_observer.dart';
import 'package:preview_play/src/features/presentation/pages/auth/register_page.dart';
import 'package:preview_play/src/features/presentation/pages/conversation/conversations_page.dart';
import 'package:preview_play/src/features/presentation/pages/test/websocket_test_page.dart';

import 'constants/common_libs.dart';
import 'src/features/presentation/pages/auth/login_page.dart';
import 'src/features/presentation/pages/chat/chat_page.dart';
import 'src/features/presentation/pages/contacts/contacts_page.dart';
import 'src/features/presentation/pages/test/pigeons_test_page.dart';
import 'src/features/presentation/pages/test/snappy_test_page.dart';

class ScreenPaths {
  static String splash = '/';
  static String login = '/login';
  static String registerPage = '/registerPage';
  static String home = '/home';
  static String conversationPage = '/conversationPage';
  static String chatPage = '/ChatPage';
  static String contactsPage = '/ContactsPage';
  static String pigeonsTestPage = '/PigeonsTestPage';
  static String snappyTestPage = '/SnappyTestPage';
  static String webSocketTestPage = '/WebSocketTestPage';
}

class AppPages {
  static final routes = [
    GetPage(
      name: ScreenPaths.splash,
      page: () => LoginPage(),
      transition: Transition.fade,
    ),
    GetPage(name: ScreenPaths.login, page: () => LoginPage()),
    GetPage(name: ScreenPaths.registerPage, page: () => RegisterPage()),
    GetPage(
      name: ScreenPaths.conversationPage,
      page: () => ConversationsPage(),
    ),
    GetPage(name: ScreenPaths.chatPage, page: () => ChatPage()),
    GetPage(name: ScreenPaths.contactsPage, page: () => ContactsPage()),
    GetPage(name: ScreenPaths.pigeonsTestPage, page: () => PigeonsTestPage()),
    GetPage(name: ScreenPaths.snappyTestPage, page: () => SnappyTestPage()),
    GetPage(
      name: ScreenPaths.webSocketTestPage,
      page: () => WebSocketTestPage(),
    ),
  ];
}

class AppRoute extends GetPage {
  AppRoute(
    String path,
    Widget Function() builder, {
    bool useFade = false,
    bool? safeTop,
    bool? safeBottom,
    bool? safeLeft,
    bool? safeRight,
    bool? resizeToAvoidBottomInset,
  }) : super(
         name: path,
         page:
             () => CupertinoScaffold(
               body: AppScaffold(
                 safeTop: safeTop ?? true,
                 safeBottom: safeBottom ?? true,
                 safeLeft: safeLeft ?? true,
                 safeRight: safeRight ?? true,
                 resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
                 child: builder(),
               ),
             ),
         transition: useFade ? Transition.fade : Transition.cupertino,
         transitionDuration: const Duration(milliseconds: 300),
       );
}

final navHistory = NavigationHistoryObserver();

class AppRouter {
  static String get currentPath => Get.currentRoute;

  static void popUntil(String name) {
    while (currentPath != name) {
      if (!Get.isDialogOpen! &&
          !Get.isBottomSheetOpen! &&
          !Get.isSnackbarOpen) {
        return;
      }
      Get.back();
    }
  }

  static void popTimes(int times) {
    if (times <= 0) return;
    var count = 0;
    while (count < times) {
      count++;
      if (!Get.isDialogOpen! &&
          !Get.isBottomSheetOpen! &&
          !Get.isSnackbarOpen) {
        return;
      }
      Get.back();
    }
  }

  static bool hasRoute(String name) {
    return Get.currentRoute == name;
  }

  static int routeSize() {
    return navHistory.history.length;
  }
}
