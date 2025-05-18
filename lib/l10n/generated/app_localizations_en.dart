// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'appName';

  @override
  String get serviceError => 'Service connection failed';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get dont_have_an_account => 'Don\'t have an account?';

  @override
  String get click_here_to_register => 'Click here to register';

  @override
  String get recentConversation => 'Recent';

  @override
  String get messages => 'Messages';

  @override
  String get userName => 'Username';

  @override
  String get alreadyHaveAnAccount => 'Already have an account';

  @override
  String get clickHereToLogin => 'Click here to login';

  @override
  String get register => 'Register';

  @override
  String get login => 'Login';

  @override
  String get contacts => 'Contact';

  @override
  String get addContact => 'Add contact';

  @override
  String get enterContactEmail => 'Enter contact email';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';

  @override
  String get api_400 => 'Service: Error parameters';

  @override
  String get api_408 => 'Service: Request timeout';

  @override
  String get api_429 => 'Service: Requests frequently';

  @override
  String get api_500 => 'Service: Internal server error';
}
