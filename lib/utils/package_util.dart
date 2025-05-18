import 'package:package_info_plus/package_info_plus.dart';

class PackageUtil {
  const PackageUtil._();

  static late PackageInfo _packageInfo;

  static String get version => _packageInfo.version;

  static String get packageName => _packageInfo.packageName;

  static String remoteVersion = version;

  static String get appName => _packageInfo.appName;

  static PackageInfo get packageInfo => _packageInfo;

  static int get buildNumber => int.tryParse(_packageInfo.buildNumber) ?? -1;
  static int remoteBuildNumber = buildNumber;

  static Future<void> initPackageInfo() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }
}
