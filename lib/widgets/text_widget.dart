import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';

class CommonText extends StatelessWidget {
  final String txt;
  final Color txtColor;
  final FontWeight txtWeight;
  final double txtSize;
  final int maxLine;

  const CommonText(this.txt,
      {Key key,
      this.txtColor = AppColor.black,
      this.txtWeight = FontWeight.normal,
      this.txtSize = 12,
      this.maxLine,})
      : super(key: key);

  CommonText.singleline(
    this.txt, {
    Key key,
    this.txtColor = AppColor.black,
    this.txtWeight = FontWeight.normal,
    this.txtSize = 12,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: TextStyle(
        color: txtColor,
        fontWeight: txtWeight,
        fontSize: txtSize,
      ),
      overflow: maxLine == 1 ? TextOverflow.ellipsis : DefaultTextStyle.of(context).overflow,
      maxLines: maxLine ?? DefaultTextStyle.of(context).maxLines,
    );
  }
}
