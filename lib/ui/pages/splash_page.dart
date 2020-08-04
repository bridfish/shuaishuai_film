import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/index_page.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Container(
        color: AppColor.white,
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
//            jumpVideoHistory(context);
            jumpIndex(context, type: IndexPage.TAB_HOME);
          },
          child: Container(
            width: 100,
            height: 100,
            child: Text("打开home页面"),
          ),
        ),
      ),
    );
  }
}
