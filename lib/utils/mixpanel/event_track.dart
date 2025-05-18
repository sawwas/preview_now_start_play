import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

enum EventTrackName {
  test('test');

  final String value;

  const EventTrackName(this.value);
}

// 埋点
class EventTrack extends GetxController {
  late Mixpanel mixpanel;

  // UserModel? _currentUser;
  Map<String, dynamic>? _cachedParameters;

  Future<void> initialize() async {
    ///测试环境
    mixpanel = await Mixpanel.init(
      'f9eecffb77ca005781f6c30927e29127',

      ///线上环境
      // mixpanel = await Mixpanel.init(
      //   'ded4faf8daa12fde28651c5d9ea19184',
      trackAutomaticEvents: false,
    );
    if (kDebugMode) {
      mixpanel.setLoggingEnabled(true);
    }
  }

  Future<void> trackEvent(
    EventTrackName eventName, {
    Map<String, dynamic>? parameters,
  }) async {
    // if (_currentUser == null) {
    //   return;
    // }

    /// 检查用户信息是否完整
    // _checkPeopleInfo();
    await mixpanel.track(
      eventName.value,
      properties: {
        ...?parameters,

        ///feat：加入平台类型
        'platform': Platform.isIOS ? 'ios' : 'android',
      },
    );

    if (kDebugMode) {
      // 立即上报
      mixpanel.flush();
    }
  }
}
