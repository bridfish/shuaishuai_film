import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

movieCustomTag(String txt, {Color color = AppColor.icon_yellow, double radius = 10}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5,),
    alignment: Alignment.center,
    height: 19,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    ),
    constraints: BoxConstraints(
      minWidth: 25
    ),
    child: Text(
      txt,
      style: TextStyle(
        fontSize: 10,
        color: Colors.white,
      ),
    ),
  );
}

movieYellowTag(String txt) {
  return movieCustomTag(txt, color: AppColor.icon_yellow);
}

movieBlueTag(String txt) {
  return movieCustomTag(txt, color: AppColor.blue);
}

rankTag({Color color = AppColor.default_txt_grey, @required String txt}) {
  return Container(
    width: 18,
    height: 18,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(5),
        bottomLeft: Radius.circular(5),
        bottomRight: Radius.circular(5),
      ),
      color: color,
    ),
    child: CommonText(
      txt,
      txtSize: 11,
      txtWeight: FontWeight.bold,
      txtColor: AppColor.white,
    ),
  );
}
