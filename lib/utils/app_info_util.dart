import 'package:package_info/package_info.dart';

class AppInfoUtil {
  static Future<PackageInfo> _initPageInfo() async {
    return await PackageInfo.fromPlatform();
  }

  static Future<String> getAppVersion() async {
    final PackageInfo packageInfo = await _initPageInfo();
    return packageInfo.version;
  }
}