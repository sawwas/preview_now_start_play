import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:preview_play/app/app_binding.dart';
import 'package:preview_play/l10n/generated/app_localizations.dart';
import 'package:preview_play/utils/app/app_style.dart';
import 'package:preview_play/utils/logs.dart';

import '../constants/common_libs.dart';
import '../env/config.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (_, child) {
        return GestureDetector(
          onTap: () {
            if (FocusManager.instance.primaryFocus?.hasFocus == true) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          child: PreviewPlayApp(),
        );
      },
    );
  }
}

class AppController extends GetxController {
  final currentLocale = app.controllerChange.currentLocale;
  final currentThemeModel = app.controllerChange.currentThemeModel;
  // final SocketService _socketService = SocketService();

  @override
  void onInit() {
    super.onInit();
    initBackgroundFetch();
    initTheme();
  }

  Future<void> initBackgroundFetch() async {
    try {
      var status = await BackgroundFetch.configure(
        BackgroundFetchConfig(
          minimumFetchInterval: 15,
          stopOnTerminate: false,
          startOnBoot: true,
          requiredNetworkType: NetworkType.ANY,
        ),
        _onBackgroundFetch,
        _onBackgroundFetchTimeout,
      );
      logger.i('[BackgroundFetch] Success: $status');
    } on Exception catch (e) {
      logger.e('[BackgroundFetch] configure ERROR: $e');
    }
  }

  void _onBackgroundFetch(String taskId) async {
    // _socketService.reconnectManualSocket();
    BackgroundFetch.finish(taskId);
  }

  void _onBackgroundFetchTimeout(String taskId) {
    BackgroundFetch.finish(taskId);
  }

  void initTheme() {
    final themeValue = app.sharedPreferences.getInt('themeMode');
    if (themeValue != null) {
      Future(() {
        if (ThemeMode.values[themeValue] == ThemeMode.system) {
          final brightness = PlatformDispatcher.instance.platformBrightness;
          final themeMode =
              brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
          currentThemeModel.value = themeMode;
        } else {
          currentThemeModel.value = ThemeMode.values[themeValue];
        }
      });
    } else {
      final brightness = PlatformDispatcher.instance.platformBrightness;
      final themeMode =
          ///TODO：测试
          brightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
      // brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light;
      Future(() {
        currentThemeModel.value = themeMode;
      });
    }
  }
}

class PreviewPlayApp extends StatelessWidget {
  const PreviewPlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    app.paddingTop = ScreenUtil().statusBarHeight;
    app.paddingBottom = ScreenUtil().bottomBarHeight;

    final lightSystemOverlay = SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
    );
    final darkSystemOverlay = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    );

    final locale = app.controllerChange.currentLocale.value;
    final themeModel = app.controllerChange.currentThemeModel.value;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: themeModel.isDark() ? lightSystemOverlay : darkSystemOverlay,
      child: OKToast(
        child: MediaQuery.withNoTextScaling(
          child: GetMaterialApp(
            navigatorObservers: [navHistory],
            initialBinding: AppBinding(),
            debugShowCheckedModeBanner: !config.isProd,
            locale: locale == null ? Locale('zh') : Locale(locale),
            // locale: locale == null ? Locale('en') : Locale(locale),
            localeResolutionCallback: (
              Locale? locale,
              Iterable<Locale> supportedLocales,
            ) {
              localeUtil.loadIfChanged(locale ?? Locale('zh'));
              // localeUtil.loadIfChanged(locale ?? Locale('en'));
              return null;
            },
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            // builder: (context, child) {
            //   return FlutterSmartDialog(child: child ?? Container());
            // },
            themeMode: themeModel,
            theme: sty.colors.toThemeData(),
            supportedLocales: AppLocalizations.supportedLocales,
            title: 'PreViewPlay',
            initialRoute: ScreenPaths.splash,
            getPages: AppPages.routes,
            defaultTransition: Transition.cupertino,
            routingCallback: (Routing? routing) {
              if (routing == null) return;

              final String to = routing.current;

              /// 未完成启动且非 Splash，重定向到 Splash
              // if (!app.isBootstrapComplete && to != ScreenPaths.splash) {
              //   Get.offAllNamed(ScreenPaths.splash);
              //   return;
              // }

              ///跳转埋点
              logger.d('AppRouter Navigate to: ${routing.current}');
            },
          ),
        ),
      ),
    );
  }
}
