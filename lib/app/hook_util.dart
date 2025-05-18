import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:preview_play/src/features/data/models/user_model.dart';
import 'package:preview_play/utils/package_util.dart';

import '../constants/common_libs.dart';
import '../utils/app/app_style.dart';

typedef AppController =
    ({
      ValueNotifier<String?> currentLocale,
      ValueNotifier<ThemeMode> currentThemeModel,
      ValueNotifier<AppTheme> currentTheme,
      ValueNotifier<Brightness> appSystemThemeChange,
      ValueNotifier<UserModel?> currentUser,
      ValueNotifier<String?> deviceId,
    });

void updateLocalUser() {
  // sp.setString(
  //   AppConstant.userInfo,
  //   json.encode(currentUser.value?.toJson()),
  // );
  // eventTrack.updateUserInfo(currentUser.value);
}

AppController createAppController({
  String? initialLocale,
  ThemeMode initialThemeMode = ThemeMode.system,
  AppTheme initialTheme = AppTheme.light,
  Brightness? systemBrightness,
  UserModel? currentUser,
  String? deviceId,
}) {
  return (
    currentLocale: ValueNotifier<String?>(initialLocale),
    currentThemeModel: ValueNotifier<ThemeMode>(initialThemeMode),
    currentTheme: ValueNotifier<AppTheme>(initialTheme),
    deviceId: ValueNotifier<String>(''),
    appSystemThemeChange: ValueNotifier<Brightness>(
      systemBrightness ?? PlatformDispatcher.instance.platformBrightness,
    ),
    currentUser: ValueNotifier<UserModel?>(null)..addListener(updateLocalUser),
  );
}

Options buildOptions({
  required AppController app,
  String? token,
  String contentType = 'application/json',
  bool isUseWsKio = false,
}) {
  return Options(
    headers: {
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      'lang': app.currentLocale.value ?? 'en',
      'platform': Platform.isAndroid ? 'android' : 'ios',
      'device-id': app.deviceId.value,
      'version': PackageUtil.version,
      'refer': 'default',
      'Content-Type': contentType,
      if (isUseWsKio) 'wskio-id': UuidUtils.getUuid(),
      // 如果需要支持额外字段：
      // 'member-id': app.currentUser.value?.id,
      // 'patch': patchVersion,
    },
  );
}
