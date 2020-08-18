import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/ui/pages/history/video_history_page.dart';
import 'package:shuaishuaimovie/ui/pages/hot/rank/hot_rank_page.dart';
import 'package:shuaishuaimovie/ui/pages/hot/update/hot_update_page.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/cartoon/cartoon_page.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/home/home_detail_page.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/index_page.dart';
import 'package:shuaishuaimovie/ui/pages/search/condition_search_page.dart';
import 'package:shuaishuaimovie/ui/pages/search/txt_search_page.dart';
import 'package:shuaishuaimovie/ui/pages/splash_page.dart';
import 'package:shuaishuaimovie/ui/pages/video/video_page.dart';

var splashHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return SplashPage();
});

var indexHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var currentTabName = params["type"][0];
  return IndexPage(currentTabName);
});

var homeDetailHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var vodId = params["id"][0];
  var imageUrl = params["imageUrl"][0];
  return HomeDetailPage(
    vodId: vodId,
    imageUrl: imageUrl,
  );
});

var hotUpdateHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TodayHotUpdatePage();
});

var rankHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return HotRankPage();
});

var cartoonHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return CartoonPage();
});

var conditionSearchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var tabType = params["tabType"][0];
  var classes = params["classes"][0];
  return ConditionSearchPage(tabType, classes: classes);
});

var txtSearchHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return TxtSearchPage();
});

var videoHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  var videoId = params["videoId"][0];
  var videoUrl = params["videoUrl"][0];
  var playUrlType = params["playUrlType"][0];
  var playUrlIndex = params["playUrlIndex"][0];
  var videoName = params["videoName"][0];
  var videoLevel = params["videoLevel"][0];
  var currentTime = params["currentTime"][0];
  return VideoPage(
    videoId: videoId,
    videoUrl: videoUrl,
    videoName: videoName,
    videoLevel: videoLevel,
    playUrlType: playUrlType,
    playUrlIndex: playUrlIndex,
    currentTime: currentTime,
  );
});

var videoHistoryHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return VideoHistoryPage();
});
