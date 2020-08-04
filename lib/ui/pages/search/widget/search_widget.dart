import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/ui/pages/search/txt_search_page.dart';

class JumpHeroTxtSearchIconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        jumpTxtSearch(context);
      },
      child: Hero(
        tag: TxtSearchPage.TXT_SEARCH,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Icon(Icons.search)),
        transitionOnUserGestures: true,
        flightShuttleBuilder: (flightContext, animation, direction,
            fromContext, toContext) {
          return Icon(Icons.arrow_back, color: AppColor.white,);
        },
      ),
    );
  }
}
