import 'dart:ui';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl_standalone.dart';

import '../constants/app_constant.dart';
import '../l10n/generated/app_localizations.dart';
import '../main.dart';

class LocaleUtil extends GetxController {
  final Locale _defaultLocal = Locale('en');

  AppLocalizations? _strings;

  AppLocalizations get strings => _strings!;

  Future<void> initialize() async {
    Locale locale = _defaultLocal;
    final String? localePrefs = sp.getString(AppConstant.appLocale);

    final localeCode = localePrefs ?? await findSystemLocale();
    locale = Locale(localeCode.split('_')[0]);

    if (AppLocalizations.supportedLocales.contains(locale) == false) {
      locale = _defaultLocal;
    }

    app.controllerChange.currentLocale.value = locale.languageCode;
    _strings = await AppLocalizations.delegate.load(locale);
  }

  Future<void> loadIfChanged(Locale locale) async {
    bool didChange = _strings?.localeName != locale.languageCode;
    if (didChange && AppLocalizations.supportedLocales.contains(locale)) {
      app.controllerChange.currentLocale.value = locale.languageCode;
      _strings = await AppLocalizations.delegate.load(locale);
      sp.setString(AppConstant.appLocale, locale.languageCode);
    }
  }
}
