import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/routes/routes.dart';
import 'package:shuaishuaimovie/shuai_movie.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/index_page.dart';
import 'package:shuaishuaimovie/widgets/clip_widget.dart';

void jumpHomeDetail(context, String vodId, String imageUrl, {replace = false}) {
  Application.router.navigateTo(
    context,
    Routes.home_detail + "/$vodId/${Uri.encodeComponent(imageUrl)}",
    replace: replace,
    transition: TransitionType.cupertino,
  );
}

void jumpRank(context) {
  Application.router.navigateTo(
    context,
    Routes.rank,
    transition: TransitionType.cupertino,
  );
}

void jumpIndex(context,
    {String type = IndexPage.TAB_HOME, clearStack = false, replace = false}) {
  Application.router.navigateTo(
    context,
    Routes.index + "/$type",
    clearStack: clearStack,
    replace: replace,
    transition: TransitionType.cupertino,
  );
}

void jumpCartoon(context) {
  Application.router.navigateTo(
    context,
    Routes.cartoon,
    transition: TransitionType.cupertino,
  );
}

jumpVideo(context,
    {String videoId,
    String videoUrl,
    String playUrlType,
    String playUrlIndex,
    String videoName,
    String videoLevel,
    String isPositive,
    String currentTime = ""}) {
  Application.router.navigateTo(
    context,
    Routes.video +
        "/$videoId/${Uri.encodeComponent(videoUrl)}/$playUrlType/$playUrlIndex/$videoName/$videoLevel/$currentTime/$isPositive",
    transition: TransitionType.cupertino,
  );
}

void jumpConditionSearch(context, String tabType, {String classes = ""}) {
  Application.router.navigateTo(
    context,
    Routes.condition_search + '/$tabType/$classes',
    transition: TransitionType.cupertino,
  );
}

void jumpTxtSearch(context) {
  Application.router.navigateTo(context, Routes.txt_search,
      transition: TransitionType.custom,
      transitionDuration: const Duration(milliseconds: 500), transitionBuilder:
          (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation, Widget child) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return ClipPath(
          clipper: CirclePath(animation.value),
          child: child,
        );
      },
      child: child,
    );
  });
}

void jumpVideoHistory(context) {
  Application.router.navigateTo(
    context,
    Routes.video_history,
    transition: TransitionType.cupertino,
  );
}
