import 'package:flutter/material.dart';

abstract class AppColors {
  Color get primary;

  Color get text;

  Color get textMedium;

  Color get textLight;

  Color get background;

  Color get lightPrimary;

  Color get deepPrimary;

  Color get green;

  Color get bgGreen;

  Color get textGray;

  Color get searchBg;

  Color get tipBg;

  Color get tipText;

  Color get textDarkest;

  Color get primaryMedium;

  Color get border;

  Color get darkNeutral;

  Color get tigWarnBg;

  Color get tigSuccessBg;

  Color get codeBorder;

  Color get error;

  Color get blue;

  Color get black;

  Color get black2;

  Color get normalButton;

  Color get blueLink;

  Color get button;

  Color get splashColor;

  Color get t1;

  Color get t2;

  Color get t3;

  Color get t4;

  Color get line1;

  Color get bg1;

  Color get bg2;

  Color get bg3;

  Color get bg4;

  Color get bg5;

  Color get neutral4;

  Color get neutral5;

  Color get neutral6;

  Color get neutral7;

  Color get neutral8;

  Color get neutral9;

  Color get divider;

  Color get card1;

  Color get cardTag;

  Color get cardButton;

  Color get deepPrimary1;

  Color get upColor;

  Color get dropColor;

  Color get progressColor;

  Color get unReadColor;

  Color get deepPurpleColor;

  Color get radiusBgColor;

  Color get cardColor;

  Color get optionColor;

  Color get chatBgColor;

  Color get conversationGroupBgColor;

  Color get conversationRoomBgColor;

  Color get pinkColor;

  Color get tipNormalBgColor;

  Color get blurBgColor;

  Color get greenColor;

  Color get orange;

  Color get yellow;

  Color get chatSubTitleColor;

  Color get chatSysTitleColor;

  ThemeData toThemeData();
}

class AppColorLight extends AppColors {
  @override
  Color get primary => Color(0xffFE3C9C);

  @override
  Color get bgGreen => Color(0xFFEDFBF5);

  @override
  Color get text => Color(0xFF000000);

  @override
  Color get textMedium => Color(0xFF494A50);

  @override
  Color get textLight => Color(0xFF8F9098);

  @override
  Color get background => bg1;

  @override
  Color get lightPrimary => Color(0xFFF8F9FE);

  @override
  Color get deepPrimary => Color(0xffFE3C9C);

  @override
  Color get green => Color(0xFF04C159);

  @override
  Color get textGray => Color(0xFF71727A);

  @override
  Color get searchBg => Color(0xFFF8F9FE);

  @override
  Color get tipBg => Color(0xFFEAF2FF);

  @override
  Color get tipText => Color(0xFF71727A);

  @override
  Color get textDarkest => Color(0xFF1F2024);

  @override
  Color get primaryMedium => Color(0xFF2897FF);

  @override
  Color get border => Color(0xFFD4D6DD);

  @override
  Color get darkNeutral => Color(0xFF2F3036);

  @override
  Color get tigWarnBg => Color(0xFFFFF8E7);

  @override
  Color get tigSuccessBg => Color(0xFFE7F4E8);

  @override
  Color get codeBorder => Color(0xFFC5C6CC);

  @override
  Color get blue => Color(0xFF2F80ED);

  @override
  Color get error => Color(0xFFED3241);

  @override
  Color get black => Color(0xFF000000);

  @override
  Color get black2 => Color(0xFF121212);

  @override
  Color get cardTag => Color(0xFFFFF4E4);

  @override
  Color get cardButton => Color(0xffFE3C9C);

  @override
  Color get normalButton => Color(0xFFF9F9F9);

  @override
  Color get splashColor => Color(0xFFF3F3F6);

  @override
  ThemeData toThemeData() {
    TextTheme txtTheme = ThemeData.light().textTheme;
    ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primary,
      onPrimary: text,
      secondary: primary,
      onSecondary: text,
      error: const Color(0xFFFF616D),
      onError: background,
      surface: background,
      onSurface: background,
    );

    final themeData = ThemeData.from(
      textTheme: txtTheme,
      colorScheme: colorScheme,
    );

    return themeData;
  }

  @override
  Color get neutral1 => bg1;

  @override
  Color get neutral10 => t1;

  @override
  Color get neutral11 => t1;

  @override
  Color get neutral2 => bg2;

  @override
  Color get neutral3 => bg3;

  @override
  Color get neutral4 => line1;

  @override
  Color get neutral5 => Color(0xFFBDBDBD);

  @override
  Color get neutral6 => Color(0xFF9B9B9B);

  @override
  Color get neutral7 => Color(0xFF656565);

  @override
  Color get neutral8 => Color(0xFF444444);

  @override
  Color get neutral9 => Color(0xFF282828);

  @override
  Color get divider => neutral11.withOpacity(0.08);

  @override
  Color get text1 => t1;

  @override
  Color get text2 => t2;

  @override
  Color get text3 => t3;

  @override
  Color get text4 => t3;

  @override
  Color get text5 => t4;

  @override
  Color get card1 => Color(0xFFFFFFFF);

  @override
  Color get deepPrimary1 => Color(0xffFE3C9C);

  @override
  Color get upColor => Color(0xFF04C159);

  @override
  Color get dropColor => Color(0xFFF54976);

  @override
  Color get progressColor => Color(0xFF15BC76);

  @override
  Color get unReadColor => Color(0xffFE3C9C);

  @override
  Color get deepPurpleColor => Color(0xFFFF288A);

  @override
  Color get radiusBgColor => Color(0xFFFFFFFF);

  @override
  Color get cardColor => Color(0xFFFFFFFF);

  @override
  Color get optionColor => Color(0xFFEB4B6D);

  @override
  Color get conversationGroupBgColor => Color(0xFFFDF6DC);

  @override
  Color get conversationRoomBgColor => Color(0xFFDDE8FD);

  @override
  Color get chatBgColor => neutral3;

  @override
  Color get pinkColor => Color(0xFFFFEEF5);

  @override
  Color get tipNormalBgColor => Color(0xFFECF1FF);

  @override
  Color get blurBgColor => Color(0x80F2F2F2);

  @override
  // TODO: implement blueLink
  Color get blueLink => Color(0xff0A59FF);

  @override
  // TODO: implement button
  Color get button => Color(0xffFE3C9C);

  @override
  // TODO: implement greenColor
  Color get greenColor => Color(0xff15BC76);

  @override
  // TODO: implement chatSubTitleColor
  Color get chatSubTitleColor => Color(0xFFA0A0A0);

  @override
  // TODO: implement chatSysTitleColor
  Color get chatSysTitleColor => Color(0xFF989898);

  @override
  // TODO: implement bg1
  Color get bg1 => Color(0xFFFFFFFF);

  @override
  // TODO: implement bg2
  Color get bg2 => Color(0xFFFCFCFD);

  @override
  // TODO: implement bg3
  Color get bg3 => Color(0xFFF5F5FA);

  @override
  // TODO: implement bg4
  Color get bg4 => Color(0xFFF5F5F9);

  @override
  // TODO: implement bg5
  Color get bg5 => Color(0xFFFFFFFF);

  @override
  // TODO: implement line1
  Color get line1 => Color(0xFFEBEBF4);

  @override
  // TODO: implement t1
  Color get t1 => Color(0xFF12122A);

  @override
  // TODO: implement t2
  Color get t2 => Color(0xFF616184);

  @override
  // TODO: implement t3
  Color get t3 => Color(0xFF8989AB);

  @override
  // TODO: implement t4
  Color get t4 => Color(0xFFC1C0D8);

  @override
  // TODO: implement orange
  Color get orange => Color(0xFFFF9142);

  @override
  // TODO: implement yellow
  Color get yellow => Color(0xFFFFB904);
}

class AppColorDark extends AppColors {
  @override
  Color get primary => Color(0xFFFA3C92);

  @override
  Color get bgGreen => Color(0xFF182734);

  @override
  Color get text => Color(0xFFFFFFFF);

  @override
  Color get textMedium => Color(0xFF494A50);

  @override
  Color get textLight => Color(0xFF8F9098);

  @override
  Color get background => bg1;

  @override
  Color get lightPrimary => Color(0xFFF8F9FE);

  @override
  Color get deepPrimary => Color(0xFFFA3C92);

  @override
  Color get green => Color(0xFF04C159);

  @override
  Color get textGray => Color(0xFF71727A);

  @override
  Color get searchBg => Color(0xFFF8F9FE);

  @override
  Color get tipBg => Color(0xFFEAF2FF);

  @override
  Color get tipText => Color(0xFF71727A);

  @override
  Color get textDarkest => Color(0xFF1F2024);

  @override
  Color get primaryMedium => Color(0xFF2897FF);

  @override
  Color get border => Color(0xFF282828);

  @override
  Color get darkNeutral => Color(0xFF2F3036);

  @override
  Color get tigWarnBg => Color(0xFFFFB904).withOpacity(0.1);

  @override
  Color get tigSuccessBg => Color(0xFFE7F4E8);

  @override
  Color get codeBorder => Color(0xFFC5C6CC);

  @override
  Color get blue => Color(0xFF2F80ED);

  @override
  Color get error => Color(0xFFED3241);

  @override
  Color get black => Color(0xFF000000);

  @override
  Color get black2 => Color(0xFF121212);

  @override
  Color get normalButton => Color(0xFF242424);

  @override
  Color get neutral1 => bg1;

  @override
  Color get neutral10 => t1;

  @override
  Color get neutral11 => t1;

  @override
  Color get neutral2 => bg2;

  @override
  Color get neutral3 => bg3;

  @override
  Color get neutral4 => line1;

  @override
  Color get neutral5 => Color(0xFF656565);

  @override
  Color get neutral6 => Color(0xFF9B9B9B);

  @override
  Color get neutral7 => Color(0xFFBDBDBD);

  @override
  Color get neutral8 => Color(0xFFE3E3E3);

  @override
  Color get neutral9 => Color(0xFFF2F2F2);

  @override
  Color get divider => neutral11.withOpacity(0.08);

  @override
  Color get splashColor => Color(0xFF24244C);

  @override
  Color get text1 => t1;

  @override
  Color get text2 => t2;

  @override
  Color get text3 => t3;

  @override
  Color get text4 => t3;

  @override
  Color get text5 => t4;

  @override
  Color get card1 => Color(0xFF1B1B1B);

  @override
  Color get deepPrimary1 => Color(0xffFE3C9C);

  @override
  Color get upColor => Color(0xFF04C159);

  @override
  Color get dropColor => Color(0xFFF54976);

  @override
  Color get progressColor => Color(0xFF15BC76);

  @override
  Color get unReadColor => Color(0xffFE3C9C);

  @override
  Color get deepPurpleColor => Color(0xFFFF288A);

  @override
  Color get radiusBgColor => neutral4;

  @override
  Color get cardColor => Color(0xFF1B1B1B);

  @override
  Color get optionColor => Color(0xFFED3241);

  @override
  Color get chatBgColor => neutral1;

  @override
  Color get conversationGroupBgColor => Color(0xFFFFF8E7).withOpacity(0.1);

  @override
  Color get conversationRoomBgColor => Color(0xFF5B90FF).withOpacity(0.1);

  @override
  Color get cardTag => Color(0xFF3F300B);

  @override
  Color get cardButton => Color(0xFFFA3C92);

  @override
  Color get pinkColor => Color(0xFF2F1E2F);

  @override
  Color get tipNormalBgColor => Color(0xff5B90FF).withOpacity(0.16);

  @override
  Color get blurBgColor => Color(0x80282828);

  @override
  // TODO: implement orange
  Color get orange => Color(0xFFFF9142);

  @override
  // TODO: implement yellow
  Color get yellow => Color(0xFFFFB904);

  @override
  ThemeData toThemeData() {
    TextTheme txtTheme = ThemeData.dark().textTheme;
    ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: primary,
      onPrimary: text,
      secondary: primary,
      onSecondary: text,
      error: const Color(0xFFFF616D),
      onError: background,
      surface: background,
      onSurface: background,
    );

    final themeData = ThemeData.from(
      textTheme: txtTheme,
      colorScheme: colorScheme,
    );

    return themeData.copyWith(
      progressIndicatorTheme: ProgressIndicatorThemeData(
        circularTrackColor: Colors.transparent,
        color: Color(0xFF444444),
      ),
    );
  }

  @override
  // TODO: implement blueLink
  Color get blueLink => Color(0xff5B90FF);

  @override
  // TODO: implement button
  Color get button => Color(0xffFA3C92);

  @override
  // TODO: implement greenColor
  Color get greenColor => Color(0xff15BC76);

  @override
  // TODO: implement chatSubTitleColor
  Color get chatSubTitleColor => Color(0xFF717171);

  @override
  // TODO: implement chatSysTitleColor
  Color get chatSysTitleColor => Color(0xff717171);

  @override
  // TODO: implement bg1
  Color get bg1 => Color(0xff12122A);

  @override
  // TODO: implement bg2
  Color get bg2 => Color(0xff181834);

  @override
  // TODO: implement bg3
  Color get bg3 => Color(0xff1B1B39);

  @override
  // TODO: implement bg4
  Color get bg4 => Color(0xff12122A);

  @override
  // TODO: implement bg5
  Color get bg5 => Color(0xff181834);

  @override
  // TODO: implement line1
  Color get line1 => Color(0xff2B2B54);

  @override
  // TODO: implement t1
  Color get t1 => Color(0xffffffff);

  @override
  // TODO: implement t2
  Color get t2 => Color(0xFF8989AB);

  @override
  // TODO: implement t3
  Color get t3 => Color(0xFF59597C);

  @override
  // TODO: implement t4
  Color get t4 => Color(0xFF383868);
}
