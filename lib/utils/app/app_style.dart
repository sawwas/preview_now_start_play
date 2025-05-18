import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../logs.dart';
import '../view/screen_util.dart';
import 'app_colors.dart';

enum AppTheme { light, dark }

class AppStyle {
  Future<void> initialize() async {}

  void toggleThemeModel() {
    final isDark = app.controllerChange.currentThemeModel.value.isDark();
    if (isDark) {
      loadIfChanged(ThemeMode.light);
    } else {
      loadIfChanged(ThemeMode.dark);
    }
  }

  void toggleTheme(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        logger.d('');
        break;
      case AppTheme.dark:
        logger.d('');
        break;
    }
  }

  Future<void> loadIfChanged(ThemeMode themeMode) async {
    bool didChange = themeMode != app.controllerChange.currentThemeModel.value;
    if (didChange) {
      app.controllerChange.currentThemeModel.value = themeMode;
    }
  }

  static const double scale = 1;

  AppColors get colors {
    final isDark = app.controllerChange.currentThemeModel.value.isDark();
    final theme = app.controllerChange.currentTheme.value;
    return isDark
        ? AppColorDark()
        : switch (theme) {
          AppTheme.light => AppColorLight(),
          AppTheme.dark => AppColorDark(),
          Object() => AppColorLight(),
          null => AppColorLight(),
        };
  }

  late final AppText text = AppText(scale);

  final Times times = Times();
}

class AppText {
  AppText(this._scale);

  final double _scale;

  TextStyle get titleFont => GoogleFonts.inter();

  TextStyle get contentFont => GoogleFonts.inter();

  late final TextStyle other1 = _createFont(
    sizePx: 48,
    weight: FontWeight.w700,
    height: 1.1,
  );

  //display：d1-d3
  late final TextStyle display1 = _createFont(
    sizePx: 32,
    weight: FontWeight.w900,
    height: 1.1,
  );
  late final TextStyle display2 = _createFont(
    sizePx: 24,
    weight: FontWeight.w800,
    height: 1.3,
    letterSpacing: 0.4,
  );
  late final TextStyle display3 = _createFont(
    sizePx: 20,
    weight: FontWeight.w800,
    height: 1.3,
    letterSpacing: 0.3,
  );
  late final TextStyle display4 = _createFont(
    sizePx: 20,
    weight: FontWeight.w800,
    height: 1.3,
    letterSpacing: 0.2,
  );

  // number: num1-num2
  late final TextStyle number0 = _createFont(
    sizePx: 48,
    weight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.36,
  ); //TODO 新增
  late final TextStyle number0Semibold = _createFont(
    sizePx: 48,
    weight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.36,
  ); //TODO 新增
  late final TextStyle number1 = _createFont(
    sizePx: 36,
    weight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0.36,
  );
  late final TextStyle number2 = _createFont(
    sizePx: 32,
    weight: FontWeight.w700,
    height: 1.2,
    letterSpacing: 0.32,
  );
  late final TextStyle number2Semibold = _createFont(
    sizePx: 32,
    weight: FontWeight.w600,
    height: 1.2,
    letterSpacing: 0.32,
  );

  // title todo 新增
  late final TextStyle title1Bold = _createFont(
    sizePx: 20,
    weight: FontWeight.w700,
    height: 1.4,
    letterSpacing: 0.36,
  ); //TODO 新增
  late final TextStyle title1Semibold = _createFont(
    sizePx: 20,
    weight: FontWeight.w600,
    height: 1.4,
    letterSpacing: 0.36,
  ); //TODO 新增
  late final TextStyle title1Medium = _createFont(
    sizePx: 20,
    weight: FontWeight.w500,
    height: 1.4,
    letterSpacing: 0.36,
  ); //TODO 新增

  //Heading: H1-H2
  late final TextStyle heading0Bold = _createFont(
    sizePx: 28,
    weight: FontWeight.w700,
    height: 1.2,
  ); //TODO 新增
  late final TextStyle heading0Semibold = _createFont(
    sizePx: 28,
    weight: FontWeight.w600,
    height: 1.2,
  ); //TODO 新增
  late final TextStyle heading1Bold = _createFont(
    sizePx: 24,
    weight: FontWeight.w700,
    height: 1.4,
  );
  late final TextStyle heading1Semibold = _createFont(
    sizePx: 24,
    weight: FontWeight.w600,
    height: 1.4,
  );
  late final TextStyle heading2Heavy = _createFont(
    sizePx: 20,
    weight: FontWeight.w800,
    height: 1.4,
  );
  @Deprecated('use title1Bold instead')
  late final TextStyle heading2Bold = _createFont(
    sizePx: 20,
    weight: FontWeight.w700,
    height: 1.4,
  );
  @Deprecated('use t1Medium instead')
  late final TextStyle heading3 = _createFont(
    sizePx: 16,
    weight: FontWeight.w700,
    height: 1.4,
    letterSpacing: -0.48,
  );
  @Deprecated('use t3Medium instead')
  late final TextStyle heading4 = _createFont(
    sizePx: 14,
    weight: FontWeight.w700,
    height: 1.4,
    letterSpacing: -0.28,
  );

  //Text：t1-t3，分别包括regular、medium、semibold
  late final TextStyle t1Regular = _createFont(
    sizePx: 16,
    weight: FontWeight.w400,
    height: 1.4,
    letterSpacing: -0.216,
  );
  late final TextStyle t1Medium = _createFont(
    sizePx: 16,
    weight: FontWeight.w500,
    height: 1.4,
    letterSpacing: -0.252,
  );
  late final TextStyle t1SemiBold = _createFont(
    sizePx: 16,
    weight: FontWeight.w600,
    height: 1.4,
    letterSpacing: -0.36,
  );

  //TODO t2和t1改为一样数值
  late final TextStyle t2Regular = _createFont(
    sizePx: 16,
    weight: FontWeight.w400,
    height: 1.4,
    letterSpacing: -0.32,
  );
  late final TextStyle t2Medium = _createFont(
    sizePx: 16,
    weight: FontWeight.w500,
    height: 1.4,
    letterSpacing: -0.44,
  );
  late final TextStyle t2SemiBold = _createFont(
    sizePx: 16,
    weight: FontWeight.w600,
    height: 1.4,
    letterSpacing: -0.44,
  );
  late final TextStyle t3Regular = _createFont(
    sizePx: 14,
    weight: FontWeight.w400,
    height: 1.4,
    letterSpacing: -0.14,
  );
  late final TextStyle t3Medium = _createFont(
    sizePx: 14,
    weight: FontWeight.w500,
    height: 1.4,
    letterSpacing: -0.14,
  );
  late final TextStyle t3SemiBold = _createFont(
    sizePx: 14,
    weight: FontWeight.w600,
    height: 1.4,
    letterSpacing: -0.14,
  );

  //TODO t4和t3改为一样数值
  late final TextStyle t4Regular = _createFont(
    sizePx: 14,
    weight: FontWeight.w400,
    height: 1.4,
    letterSpacing: -0.13,
  );
  late final TextStyle t4Medium = _createFont(
    sizePx: 14,
    weight: FontWeight.w500,
    height: 1.4,
    letterSpacing: -0.13,
  );
  late final TextStyle t4SemiBold = _createFont(
    sizePx: 14,
    weight: FontWeight.w600,
    height: 1.4,
    letterSpacing: -0.13,
  );
  late final TextStyle t5Regular = _createFont(
    sizePx: 12,
    weight: FontWeight.w400,
    height: 1.4,
    letterSpacing: -0.13,
  );
  late final TextStyle t5Medium = _createFont(
    sizePx: 12,
    weight: FontWeight.w500,
    height: 1.4,
    letterSpacing: -0.13,
  );
  late final TextStyle t5SemiBold = _createFont(
    sizePx: 12,
    weight: FontWeight.w600,
    height: 1.4,
    letterSpacing: -0.13,
  );

  //info
  late final TextStyle infoRegular = _createFont(
    sizePx: 10,
    weight: FontWeight.w400,
    height: 1.4,
    letterSpacing: -0.1,
  );
  late final TextStyle infoMedium = _createFont(
    sizePx: 10,
    weight: FontWeight.w500,
    height: 1.4,
    letterSpacing: -0.1,
  );
  late final TextStyle infoSemiBold = _createFont(
    sizePx: 10,
    weight: FontWeight.w600,
    height: 1.4,
    letterSpacing: -0.1,
  );

  TextStyle _createFont({
    required double sizePx,
    FontWeight? weight,
    double? height,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontSize: sizePx * _scale,
      fontWeight: weight,
      fontFamily: 'Switzer Complete',
      height: height,
    );
  }
}

@immutable
class Times {
  final Duration fast = Duration(milliseconds: 300);
  final Duration med = Duration(milliseconds: 600);
  final Duration slow = Duration(milliseconds: 900);
  final Duration pageTransition = Duration(milliseconds: 200);
}

extension ThemeModeExtension on ThemeMode {
  bool isDark() {
    if (this == ThemeMode.system) {
      return ScreenUtil.platformBrightness ==
          PlatformDispatcher.instance.platformBrightness;
    }
    return this == ThemeMode.dark;
  }
}

extension ColorSet on TextStyle {
  TextStyle colorSet(Color color) {
    return copyWith(color: color);
  }
}

extension FontWeightSet on TextStyle {
  TextStyle fontWeightSet(FontWeight fontWeight) {
    return copyWith(fontWeight: fontWeight);
  }
}
