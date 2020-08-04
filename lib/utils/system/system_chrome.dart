import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shuaishuaimovie/res/app_color.dart';

class MovieSystemChrome {
  static const SystemUiOverlayStyle statusDark = SystemUiOverlayStyle(
    statusBarColor: Color(0xFF000000),
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  );

  static const SystemUiOverlayStyle statusTransparent = SystemUiOverlayStyle(
    statusBarColor: AppColor.transparent,
    statusBarBrightness: Brightness.dark,
  );
}