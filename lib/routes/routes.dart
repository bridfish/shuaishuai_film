import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:shuaishuaimovie/ui/pages/not_found_page.dart';
import 'package:shuaishuaimovie/routes/route_handlers.dart';

class Routes {
  static String splash = '/';
  static String index = '/index';
  static String home_detail = '/home/detail';
  static String video = '/video';
  static String hot_update = '/home/hotUpdate';
  static String rank = '/rank';
  static String cartoon = '/cartoon';
  static String condition_search = '/condition_search';
  static String txt_search = '/txt_search';
  static String video_history = '/video_history';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print("ROUTE WAS NOT FOUND !!!");
        return NotFoundPage();
      }
    );

    router.define(splash, handler: splashHandler);
    //type为0,1,2,3,4分别对应底部的tab。
    router.define(index + "/:type", handler: indexHandler);
    router.define(home_detail + "/:id/:imageUrl", handler: homeDetailHandler);
    router.define(video + "/:videoId/:videoUrl/:playUrlType/:playUrlIndex/:videoName/:videoLevel", handler: videoHandler);
    router.define(hot_update, handler: hotUpdateHandler);
    router.define(rank, handler: rankHandler);
    router.define(cartoon, handler: cartoonHandler);
    router.define(condition_search + "/:tabType/:classes", handler: conditionSearchHandler);
    router.define(txt_search, handler: txtSearchHandler);
    router.define(video_history, handler: videoHistoryHandler);
  }
}

