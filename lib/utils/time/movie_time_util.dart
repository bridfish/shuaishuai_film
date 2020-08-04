import 'package:date_format/date_format.dart';

class MovieTimeUtil {
  static String getVodTime(int vodTime) {
    var date =
    DateTime.fromMillisecondsSinceEpoch(vodTime * 1000);
    return formatDate(date, [mm, '-', dd]);
  }

  static int currentTimeMillis() {
    return DateTime.now().millisecondsSinceEpoch;
  }
}