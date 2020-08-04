import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class CustomChewieOverlayWidget extends StatelessWidget {
  CustomChewieOverlayWidget({this.onTap, this.tipsMsg, this.tapMsg});
  VoidCallback onTap;
  String tipsMsg;
  String tapMsg;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.black,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CommonText(
            tipsMsg,
            txtSize: 14,
            txtColor: AppColor.white,
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: AppColor.grey.withOpacity(.5)),
              child: CommonText(
                tapMsg,
                txtSize: 14,
                txtColor: AppColor.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
