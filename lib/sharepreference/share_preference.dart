import 'package:shared_preferences/shared_preferences.dart';

class MovieSharePreference {
  static const String AUTO_PLAY = "auto_play";
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  static void saveAutoPlayValue(bool isAutoPlay) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool(AUTO_PLAY, isAutoPlay);
  }

  static Future<bool> getAutoPlayValue() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getBool(AUTO_PLAY);
  }

}