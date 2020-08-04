import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';

class CustomProgressPaint extends CustomPainter {
   CustomProgressPaint({
     this.currentProgress = 0,
     this.bgColor = AppColor.grey,
   this.progressColor = AppColor.icon_yellow,
   });
   int currentProgress = 0;
   Color bgColor;
   Color progressColor;

  @override
  void paint(Canvas canvas, Size size) {
    double eWidth = size.width;
    double eHeight = size.height;

    var bgPaint = Paint()
    ..isAntiAlias = true
    ..style = PaintingStyle.fill
    ..color = bgColor;

    //绘制背景色
    canvas.drawRect(Offset.zero & size, bgPaint);

    //绘制进度
    var progressPaint = bgPaint..color = progressColor;
    canvas.drawRect(Offset.zero & Size(eWidth * currentProgress / 100.0, eHeight), progressPaint);

  }

  @override
  bool shouldRepaint(CustomProgressPaint oldDelegate) {
    return oldDelegate.currentProgress != this.currentProgress;
  }

}