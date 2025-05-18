// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appName => 'app名称';

  @override
  String get serviceError => '服务连接失败';

  @override
  String get email => '邮箱';

  @override
  String get password => '密码';

  @override
  String get dont_have_an_account => '没有帐户？';

  @override
  String get click_here_to_register => '单击此处注册';

  @override
  String get recentConversation => '最近的';

  @override
  String get messages => '消息';

  @override
  String get userName => '用户昵称';

  @override
  String get alreadyHaveAnAccount => '已经有一个帐户';

  @override
  String get clickHereToLogin => '单击此处登录';

  @override
  String get register => '注册';

  @override
  String get login => '登录';

  @override
  String get contacts => '联系薄';

  @override
  String get addContact => '添加联系人';

  @override
  String get enterContactEmail => '输入联系人邮箱';

  @override
  String get cancel => '取消';

  @override
  String get add => '添加';

  @override
  String get api_400 => '服务：参数错误';

  @override
  String get api_408 => '服务：请求超时';

  @override
  String get api_429 => '服务：请求频繁';

  @override
  String get api_500 => '服务：内部错误';
}
