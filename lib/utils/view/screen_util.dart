import 'package:flutter/material.dart';

class ScreenUtil {
  const ScreenUtil._();

  static final MediaQueryData mediaQueryData = MediaQueryData.fromView(
    WidgetsBinding.instance.platformDispatcher.views.first,
  );
  static final double screenWidth = mediaQueryData.size.width;
  static final double screenHeight = mediaQueryData.size.height;

  static final double statusBarHeight = mediaQueryData.padding.top;
  static final double bottomBarHeight = mediaQueryData.padding.bottom;

  static final double devicePixelRatio = mediaQueryData.devicePixelRatio;
  static final Brightness platformBrightness =
      mediaQueryData.platformBrightness;
}
