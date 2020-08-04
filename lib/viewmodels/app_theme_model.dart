import 'package:flutter/cupertino.dart';
import 'package:shuaishuaimovie/res/app_color.dart';

class AppTheme extends ChangeNotifier{
  Color iconThemeColor = AppColor.default_icon_grey;
  Color txtColor = AppColor.default_txt_grey;

  void setIconThemeColor(Color iconThemeColor) {
    this.iconThemeColor = iconThemeColor;
  }

  void setTxtColor(Color txtColor) {
    this.txtColor = txtColor;
  }

  void setHomeDetailPageThemeColor() {
    setIconThemeColor(AppColor.white);
    setTxtColor(AppColor.white);
  }

  void setHomePageThemeColor() {
    setIconThemeColor(AppColor.default_icon_grey);
    setTxtColor(AppColor.default_txt_grey);
  }

  void setDynamicActionBarColor({Color iconThemeColor, Color txtColor}) {
    setIconThemeColor(iconThemeColor ?? AppColor.default_icon_grey);
    setTxtColor(txtColor ?? AppColor.default_txt_grey);
  }
}