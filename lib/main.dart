import 'dart:async';
import 'dart:io';

import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/foundation.dart';
// import 'package:flutter_snappy/flutter_snappy.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:openinstall_flutter_plugin/openinstall_flutter_plugin.dart';
import 'package:path_provider/path_provider.dart';
import 'package:preview_play/src/features/data/api/auth_api.dart';
import 'package:preview_play/src/features/data/api/contacts_api.dart';
import 'package:preview_play/src/features/data/api/conversations_api.dart';
import 'package:preview_play/src/features/data/api/messages_api.dart';
import 'package:preview_play/src/features/data/api/notice_api.dart';
import 'package:preview_play/src/features/data/repositories/auth_repository_impl.dart';
import 'package:preview_play/src/features/data/repositories/conversations_repository_impl.dart';
import 'package:preview_play/src/features/data/repositories/notice_repository_impl.dart';
import 'package:preview_play/utils/app/app_style.dart';
import 'package:preview_play/utils/exception/exception_util.dart';
import 'package:preview_play/utils/locale_util.dart';
import 'package:preview_play/utils/logs.dart';
import 'package:preview_play/utils/mixpanel/event_track.dart';
import 'package:preview_play/utils/network/http_util.dart';
import 'package:preview_play/utils/package_util.dart';
import 'package:preview_play/utils/sentry/const.dart';
import 'package:preview_play/utils/sentry/logger/errorHandler.dart';
import 'package:preview_play/utils/sentry/logger/isError.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/app_util.dart';
import 'constants/common_libs.dart';
import 'env/config.dart';
import 'src/features/data/repositories/contacts_repository_impl.dart';
import 'src/features/data/repositories/message_repository_impl.dart';
import 'l10n/generated/app_localizations.dart';

Directory? appExtDir;
Directory? appDocumentDir;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  /// sentry
  //https://docs.sentry.io/platforms/flutter/integrations/slow-and-frozen-frames-instrumentation/
  SentryWidgetsFlutterBinding.ensureInitialized();

  // FlutterSnappy.initialize();

  await SentryFlutter.init(
    (options) {
      options
        ..addIntegration(
          RunZonedGuardedIntegration(
            () async {
              appExtDir = await getTemporaryDirectory();
              appDocumentDir = await getApplicationDocumentsDirectory();
              sl.registerLazySingleton<AppUtils>(() => AppUtils());
              await app.preSharedPreferences();

              /// package info
              await PackageUtil.initPackageInfo();

              Stripe.publishableKey = config.stripePublishableKey;
              Stripe.merchantIdentifier = config.merchantIdentifier;

              registerSingletons();
              await app.preBootstrap();
              OpeninstallFlutterPlugin().init(_wakeupHandler);
              // EasyRefresh.defaultFooterBuilder = () => ClassicFooter(
              //       noMoreText: str.noMore,
              //       messageText: str.lastUpdateAt('%T'),
              //     );
              EasyRefresh.defaultHeaderBuilder = () => CupertinoHeader();
              EasyRefresh.defaultFooterBuilder = () => CupertinoFooter();
              if (kDebugMode) {
                final proxy = Environment().proxy;
                debugPrint('debug proxy: $proxy');
                if (proxy.isNotEmpty) {
                // HttpOverrides.global = MyHttpOverrides(
                //   proxy: "192.168.1.192:9090",
                // );
                HttpOverrides.global = MyHttpOverrides(proxy: proxy);
                }
              }
              // final socketService = SocketService();
              // await socketService.initSocket();
            },
            (error, stackTrace) {
              logger.d('run main error: $error; stack: $stackTrace');
              ExceptionUtil.handleGlobal(error, stackTrace);
              if (Sentry.isEnabled && isError(error) && error is Exception) {
                final transaction = Sentry.startTransaction(
                  'processOrderBatch()',
                  'task',
                  bindToScope: true,
                );
                var detail = errorHandler(
                  ErrorLevel.fatal,
                  AppRouter.currentPath,
                  'page crash err',
                  err: error,
                  context: null,
                );
                final reason = detail.reason;
                final level = detail.level;
                final err = detail.error;
                final reasonStr = reason ?? '';
                err.message = '[Page] - page crash err$reasonStr}';
                transaction.startChild(
                  'data_reason',
                  description: reason,
                  startTimestamp: DateTime.now(),
                );
                transaction.startChild(
                  'data_level',
                  description: level.name,
                  startTimestamp: DateTime.now(),
                );
                transaction.startChild(
                  'data_err',
                  description: err.toString(),
                  startTimestamp: DateTime.now(),
                );
                Sentry.captureException(error);
                transaction.finish(status: SpanStatus.internalError());
              }
            },
          ),
        )
        ..dsn = SENTRY_DSN
        ..debug = false
        ..diagnosticLevel = SentryLevel.error;
    },
    appRunner:
        () => runApp(
          DefaultAssetBundle(bundle: SentryAssetBundle(), child: MyApp()),
        ),
  );
}

const kOpenInstallRefUserKey = 'kOpenInstallRefUser';

Future<void> _wakeupHandler(Map<String, Object> data) async {
  logger.d('App Wake Up--->$data');
}

void registerSingletons() {
  sl.registerLazySingleton<LocaleUtil>(() => LocaleUtil());
  sl.registerLazySingleton<AppStyle>(() => AppStyle());
  sl.registerLazySingleton<EventTrack>(() => EventTrack());

  //Notice
  sl.registerLazySingleton<NoticeApi>(() => NoticeApi());
  sl.registerLazySingleton<NoticeRepositoryImpl>(
    () => NoticeRepositoryImpl(noticeApi: sl()),
  );

  //Auth
  sl.registerLazySingleton<AuthApi>(() => AuthApi());
  sl.registerLazySingleton<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(authApi: sl()),
  );

  //Conversation
  sl.registerLazySingleton<ConversationsApi>(() => ConversationsApi());
  sl.registerLazySingleton<ConversationsRepositoryImpl>(
    () => ConversationsRepositoryImpl(conversationApi: sl()),
  );

  //Message
  sl.registerLazySingleton<MessagesApi>(() => MessagesApi());
  sl.registerLazySingleton<MessagesRepositoryImpl>(
    () => MessagesRepositoryImpl(messageApi: sl()),
  );

  //Contact
  sl.registerLazySingleton<ContactsApi>(() => ContactsApi());
  sl.registerLazySingleton<ContactsRepositoryImpl>(
    () => ContactsRepositoryImpl(contactsApi: sl()),
  );
}

LocaleUtil get localeUtil => sl.get<LocaleUtil>();

AppStyle get sty => sl.get<AppStyle>();

AppUtils get app => sl.get<AppUtils>();

EventTrack get eventTrack => sl.get<EventTrack>();

AppLocalizations get str => localeUtil.strings;

SharedPreferences get sp => app.sharedPreferences;

class MyHttpOverrides extends HttpOverrides {
  final String proxy;

  MyHttpOverrides({required this.proxy});

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    var http = super.createHttpClient(context);
    http.findProxy = (uri) {
      return 'PROXY $proxy';
    };
    http.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return http;
  }
}
