import 'dart:io';

import 'package:preview_play/constants/common_libs.dart';
import 'package:preview_play/utils/package_util.dart';

import 'dev.dart';
import 'prod.dart';

const bool _isProd = bool.fromEnvironment('isProd', defaultValue: true);
const bool _isDebug = bool.fromEnvironment('isDebug', defaultValue: false);
const String _proxy = String.fromEnvironment('proxy', defaultValue: '');

class Environment {
  static final Environment _instance = Environment._internal();

  Environment._internal() {
    // 版本号切换当前环境
    _appIsProd =
        app.sharedPreferences.getBool(
          '${AppConstant.envIsProd}-${PackageUtil.buildNumber}',
        ) ??
        _isProd;
  }

  factory Environment() {
    return _instance;
  }

  bool get isDev => !_appIsProd;

  bool get isProd => _appIsProd;

  bool get isDebug => _isDebug;

  String get proxy => _proxy;

  bool _appIsProd = true;

  bool get isShowSwitchEnv {
    return true;
  }

  BaseConfig get config {
    if (isProd) {
      return PConfig();
    } else {
      return DConfig();
    }
  }

  // 切换环境
  void switchEnv() async {
    await app.sharedPreferences.setBool(
      '${AppConstant.envIsProd}-${PackageUtil.buildNumber}',
      !_appIsProd,
    );

    // 清除app所有信息
    await app.logout();

    //TODO: 清除其他内容

    // 杀死app
    exit(0);
  }
}

BaseConfig get config => Environment().config;

abstract class BaseConfig {
  bool get isProd => Environment().isProd;

  bool get isDebug => Environment().isDebug;

  String get stripePublishableKey;

  String get merchantIdentifier => 'merchant.app.tomo';

  String get appBackendAddress;

  String get appBackendSocket;

  String get keyBase64;

  String get ivBase64;
}
