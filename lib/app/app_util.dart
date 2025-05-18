import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_util_code/utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import '../utils/logs.dart';
import '../utils/network/http_util.dart';
import 'hook_util.dart';

class AppUtils {
  bool isBootstrapComplete = false;

  late BuildContext appContext;
  late SharedPreferences sharedPreferences;
  var controllerChange = createAppController();

  // final currentLocale = ValueNotifier<String?>(null);
  // final currentThemeModel = ValueNotifier<ThemeMode>(ThemeMode.system);
  // final currentTheme = ValueNotifier<AppTheme>(AppTheme.light);

  ///优化iOS主题同步
  // final appExchangeThemeTimeForiOS = ValueNotifier<DateTime>(DateTime.now());
  // final appExchangeThemeTimeForiOSReal = ValueNotifier<DateTime>(
  //   DateTime.now(),
  // );
  // final appSystemThemeChange = ValueNotifier<Brightness>(
  //   PlatformDispatcher.instance.platformBrightness,
  // );

  // late final currentUser = ValueNotifier<UserModel?>(null)
  //   ..addListener(updateLocalUser);

  // late final currentUserWalletAddress = ValueNotifier<UserWalletAddress?>(null);

  double paddingTop = 0.0;
  double paddingBottom = 0.0;

  Future<void> preSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> preBootstrap() async {
    app.controllerChange.deviceId.value = await DeviceUtils.getDeviceId();

    await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    /// intl
    await localeUtil.initialize();

    /// theme
    await sty.initialize();

    /// http
    await HttpUtil.init();
    // await WalletKit.startDataSync();
  }

  Future<void> bootstrap() async {
    logger.d('bootstrap start...');
    optBootstrap();
    // if (FirebaseRemoteConfig.instance.getBool('startup_opt') == true) {
    //   return optBootstrap();
    // }
    DateTime startTime = DateTime.now();

    /// im client

    /// local database
    // await hiveUtils.initialize();

    await eventTrack.initialize();

    ///超过15天清理所有缓存
    var sharedPerBuildNumber = app.sharedPreferences.getInt(
      'cache_expiration_time',
    );
    if (sharedPerBuildNumber != null) {
      final difference =
          DateTime.now()
              .difference(
                DateTime.fromMillisecondsSinceEpoch(sharedPerBuildNumber),
              )
              .inDays;
      if (difference >= 15) {
        ///fix: 清除所有缓存
        app.clearAllUserData();
        app.sharedPreferences.setInt(
          'cache_expiration_time',
          DateTime.now().millisecondsSinceEpoch,
        );
        logger.d(
          '===========================清除所有缓存===========================',
        );
      }
    } else {
      app.sharedPreferences.setInt(
        'cache_expiration_time',
        DateTime.now().millisecondsSinceEpoch,
      );
    }

    /// disable player log
    // FijkLog.setLevel(FijkLogLevel.Error);

    // await Future.delayed(Duration(milliseconds: 300));
    /// load user
    // final user = await loginUtils.userStateRecovery();

    Duration executionTime = DateTime.now().difference(startTime);
    app.isBootstrapComplete = true;
    logger.d(
      'bootstrap end... execution time: ${executionTime.inMilliseconds} ms',
    );

    // 清理旧的ffmpeg缓存文件
    // cleanupOldCache();
    // JsEngine().init();
  }

  Future<void> optBootstrap() async {
    logger.i('bootstrap start...');
    DateTime startTime = DateTime.now();

    //IM init

    //DB init

    // await Future.wait([
    //   configureAmplify(),
    //   momentUtils.initialize(),
    //   hiveUtils.initialize(),
    //   eventTrack.initialize()
    // ]);

    ///超过15天清理所有缓存
    var sharedPerBuildNumber = app.sharedPreferences.getInt(
      'cache_expiration_time',
    );
    if (sharedPerBuildNumber != null) {
      final difference =
          DateTime.now()
              .difference(
                DateTime.fromMillisecondsSinceEpoch(sharedPerBuildNumber),
              )
              .inDays;
      if (difference >= 15) {
        ///fix: 清除所有缓存
        app.clearAllUserData();
        app.sharedPreferences.setInt(
          'cache_expiration_time',
          DateTime.now().millisecondsSinceEpoch,
        );
        logger.d(
          '===========================清除所有缓存===========================',
        );
      }
    } else {
      app.sharedPreferences.setInt(
        'cache_expiration_time',
        DateTime.now().millisecondsSinceEpoch,
      );
    }

    Duration executionTime = DateTime.now().difference(startTime);
    app.isBootstrapComplete = true;
    // JsEngine().init();
    logger.d(
      'bootstrap end... execution time: ${executionTime.inMilliseconds} ms',
    );
  }

  /// 1. request logout app api
  /// 2. logout im client
  /// 3. redirect router
  Future<void> logout() async {
    /// TODO request http logout
    // await loginUtils.logout();
    // imUtils.logout();
    sp.remove('notification_tag_select');

    ///fix: 清除缓存
    await clearAllUserData();

    //https://docs.sentry.io/platforms/flutter/enriching-events/scopes/
    Sentry.configureScope((scope) => scope.setUser(null));
  }

  void updateLocalUser() {
    // sp.setString(
    //   AppConstant.userInfo,
    //   json.encode(currentUser.value?.toJson()),
    // );
    // eventTrack.updateUserInfo(currentUser.value);
  }

  // Future<void> initUpdateApp(BuildContext context) async {
  //   UpdateInfo? info;
  //   try {
  //     final r = await FansTechApi.getAppVersion();
  //     if (Platform.isAndroid) {
  //       info = r.androidInfo;
  //     } else {
  //       info = r.iosInfo;
  //     }
  //   } catch (e) {
  //     logger.d('getAppVersion error: $e');
  //   }
  //   final lastBuildNumber = info?.buildNumber ?? -1;
  //   final currentBuildNumber = PackageUtil.buildNumber;
  //   final isForce = info?.force == true;
  //   if (currentBuildNumber < lastBuildNumber) {
  //     if (isForce == false) {
  //       // 24 小时内已提示过，中断不做提示
  //       final lastShowTime =
  //           sp.getInt(AppConstant.appVersionLastUpdateTime) ?? 0;
  //       final now = DateTime.now().millisecondsSinceEpoch;
  //       if (now - lastShowTime < 24 * 60 * 60 * 1000) {
  //         return;
  //       }
  //       sp.setInt(AppConstant.appVersionLastUpdateTime, now);
  //     }
  //     UpdateLanInfo? lanInfo;
  //     try {
  //       final updateLan = await FansTechApi.getAppUpdateLan(lastBuildNumber);
  //       if (Platform.isAndroid) {
  //         lanInfo = updateLan.androidInfo;
  //       } else {
  //         lanInfo = updateLan.iosInfo;
  //       }
  //     } catch (_) {}
  //     Future.delayed(
  //       Duration.zero,
  //       () => SizedBox.shrink(),
  //       // showUpdateDialog(context,
  //       // isForce: isForce, info: info!, lanInfo: lanInfo),
  //     );
  //   }
  // }

  ///fix: 清除缓存
  Future<void> clearAppCache() async {
    const platform = MethodChannel('com.preview.play/cache');
    try {
      var isClearCache = await platform.invokeMethod('clearCache');
      logger.d('clearCache: $isClearCache');
    } on PlatformException catch (e) {
      logger.d("Failed to clear cache: '${e.message}'.");
    }
  }

  Future<void> clearAllUserData() async {
    try {
      ///fix: 清除缓存
      await clearAppCache();
    } catch (e) {
      logger.d(e);
    }
  }
}
