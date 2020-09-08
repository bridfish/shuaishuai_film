import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/shuai_movie.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/home/homewidget//home_detail_widget.dart';
import 'package:shuaishuaimovie/utils/time/movie_time_util.dart';
import 'package:shuaishuaimovie/viewmodels/tab/home/home_detail_model.dart';
import 'package:shuaishuaimovie/widgets/app_bar.dart';
import 'package:shuaishuaimovie/widgets/panel_widget.dart';
import 'package:shuaishuaimovie/widgets/rating_bar.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class AppBarTheme {
  AppBarTheme(this.txtColor, this.iconColor, this.bgOpacity);

  Color txtColor;
  Color iconColor;
  double bgOpacity;
}

class HomeDetailPage extends StatefulWidget {
  final String vodId;
  final String imageUrl;

  const HomeDetailPage({Key key, this.vodId, this.imageUrl}) : super(key: key);

  @override
  _HomeDetailPageState createState() => _HomeDetailPageState();
}

class _HomeDetailPageState extends State<HomeDetailPage> {
  ScrollController _scrollController;
  ValueNotifier<AppBarTheme> _appBarValueNotifier;
  double lastScroll = 0;

  @override
  void initState() {
    super.initState();
    _appBarValueNotifier = ValueNotifier<AppBarTheme>(
        AppBarTheme(AppColor.white, AppColor.white, 0));

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      //解决滑动速度过快，达不到想要的效果。
      final scrollOffset = _scrollController.offset;
      if (scrollOffset > 0 && scrollOffset < 100) {
        if (lastScroll != 0 && (scrollOffset - lastScroll).abs() <= 10) {
          return;
        }
        lastScroll = scrollOffset;
        double opacityValue = scrollOffset / 100;
        _appBarValueNotifier.value = AppBarTheme(
            Color.lerp(AppColor.white, AppColor.default_txt_grey, opacityValue),
            Color.lerp(
                AppColor.white, AppColor.default_icon_grey, opacityValue),
            opacityValue);
      } else if (scrollOffset <= 0) {
        if (_appBarValueNotifier.value.bgOpacity == 0) return;
        _appBarValueNotifier.value =
            AppBarTheme(AppColor.white, AppColor.white, 0);
      } else if (scrollOffset >= 100) {
        if (_appBarValueNotifier.value.bgOpacity == 1) return;
        _appBarValueNotifier.value = AppBarTheme(
            AppColor.default_txt_grey, AppColor.default_icon_grey, 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Container(
          color: AppColor.white,
          child: ProviderWidget<HomeDetailViewModel>(
            initData: (model) {
              loadData(model);
            },
            model: HomeDetailViewModel(),
            builder: (context, model, child) {
              if (!model.isSuccess()) {
                return CommonViewStateHelper(
                  model: model,
                  onEmptyPressed: () => loadData(model),
                  onErrorPressed: () => loadData(model),
                  onNoNetworkPressed: () => loadData(model),
                );
              }
              return _buildHomeDetailContent(model);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHomeDetailContent(HomeDetailViewModel model) {
    debugPrint("_buildHomeDetailContent");
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          controller: _scrollController,
          child: Stack(
            children: <Widget>[
              HomeDetailBackGroundWidget(
                imageUrl: Uri.decodeComponent(widget.imageUrl),
              ),
              Container(
                margin: EdgeInsets.only(top: 180),
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 180,
                ),
                padding: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                  color: AppColor.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _contentHeader(model),
                    if (model.playUrls != null && model.playUrls.length > 0)
                      _playBtn(model),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: CommonText(
                        "剧情介绍",
                        txtColor: AppColor.icon_yellow,
                        txtSize: 18,
                        txtWeight: FontWeight.bold,
                      ),
                    ),
                    IntroducePanelWidget(
                      content: model.homeDetailBeanVod.vodContent,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MovieSelectionModuleWidget(
                      model.playUrls,
                      onAssembleTap: (index, flag) {
                         final tempIndex = flag ? model.playUrls.length - 1 - index : index;
                        _jumpVideo(
                          model.homeDetailBeanVod.vodID.toString(),
                          model.playUrls[tempIndex][1],
                          index.toString(),
                          model.playUrlType,
                          model.homeDetailBeanVod.vodName,
                          model.playUrls[tempIndex][0],
                          flag ? "1" : "0",
                        );
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    RandModuleWidget(model),
                    RelateModuleWidget(model),
                    SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ValueListenableBuilder<AppBarTheme>(
          valueListenable: _appBarValueNotifier,
          builder: (_, value, __) {
            debugPrint("_appBarValueNotifier");
            return CustomAppBar(
              backgroundColor: AppColor.white.withOpacity(value.bgOpacity),
              logoPosition: LogoPosition.Center,
              iconColor: value.iconColor,
              txtColor: value.txtColor,
              contentHeight: 50,
              onPressedBack: () {
                _backHomePage();
              },
            );
          },
        ),
      ],
    );
  }

  Widget _contentHeader(HomeDetailViewModel model) {
    return Container(
      height: 110,
      child: OverflowBox(
        maxHeight: 180,
        alignment: Alignment.bottomLeft,
        child: Row(
          children: <Widget>[
            Container(
              height: 180,
              width: 257 / 360 * 180,
              child: CachedNetworkImage(
                imageUrl: model.homeDetailBeanVod.vodPic,
                fit: BoxFit.cover,
                placeholder: (context, url) {
                  return Center(
                    child: CupertinoActivityIndicator(),
                  );
                },
                errorWidget: (context, url, error) {
                  return Icon(
                    Icons.error,
                    size: 30,
                    color: AppColor.icon_yellow,
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CommonText(
                      model.homeDetailBeanVod.vodName,
                      txtColor: AppColor.paper,
                      txtSize: 17,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        CommonText(
                          model.homeDetailBeanVod.vodScore.toStringAsFixed(1),
                          txtColor: AppColor.icon_yellow,
                          txtSize: 13,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: StarRatingBar.onlyShow(
                            selectedCount:
                                model.homeDetailBeanVod.vodScore ~/ 2,
                            selectedStarColor: AppColor.icon_yellow,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        CommonText(
                          model.homeDetailBeanVod.vodYear,
                          txtSize: 12,
                        ),
                        Container(
                          width: 1,
                          height: 10,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          color: AppColor.default_txt_grey,
                        ),
                        CommonText(
                          model.homeDetailBeanVod.vodArea,
                          txtSize: 12,
                        ),
                        Container(
                          width: 1,
                          height: 10,
                          margin: EdgeInsets.only(left: 5, right: 5),
                          color: AppColor.default_txt_grey,
                        ),
                        CommonText(
                          model.homeDetailBeanVod.vodClass.typeName,
                          txtSize: 12,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        CommonText(
                          "状态: ",
                          txtSize: 12,
                          txtColor: AppColor.default_txt_grey,
                        ),
                        Expanded(
                          child: CommonText(
                            model.homeDetailBeanVod.vodRemarks,
                            txtSize: 12,
                            txtColor: AppColor.red,
                            maxLine: 1,
                          ),
                        ),
                        CommonText(
                          " / ",
                          txtSize: 12,
                          txtColor: AppColor.default_txt_grey,
                        ),
                        CommonText(
                          MovieTimeUtil.getVodTime(
                              model.homeDetailBeanEntity.vod.vodTime),
                          txtSize: 12,
                          txtColor: AppColor.default_txt_grey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        CommonText(
                          "主演: ",
                          txtSize: 12,
                          txtColor: AppColor.default_txt_grey,
                        ),
                        Expanded(
                          child: CommonText.singleline(
                            model.homeDetailBeanVod.vodActor,
                            txtSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: <Widget>[
                        CommonText(
                          "导演: ",
                          txtSize: 12,
                          txtColor: AppColor.default_txt_grey,
                        ),
                        Expanded(
                          child: CommonText.singleline(
                            model.homeDetailBeanVod.vodDirector,
                            txtSize: 12,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _playBtn(HomeDetailViewModel model) {
    return GestureDetector(
      onTap: () {
        _jumpVideo(widget.vodId, model.playUrls[0][1], "0", model.playUrlType,
            model.homeDetailBeanVod.vodName, model.playUrls[0][0], "0");
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.icon_yellow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.arrow_right,
              color: AppColor.white,
              size: 18,
            ),
            CommonText(
              "立即播放",
              txtColor: AppColor.white,
              txtSize: 14,
            ),
          ],
        ),
      ),
    );
  }

  void _jumpVideo(
    String videoId,
    String videoUrl,
    String playUrlIndex,
    String playUrlType,
    String videoName,
    String videoLevel,
    String isPositive,
  ) {
    jumpVideo(
      context,
      videoId: videoId,
      videoUrl: videoUrl,
      playUrlIndex: playUrlIndex,
      playUrlType: playUrlType,
      videoName: videoName,
      videoLevel: videoLevel,
      isPositive: isPositive,
    );
  }

  void _backHomePage() {
    Application.router.pop(context);
  }

  Future<dynamic> loadData(HomeDetailViewModel model) async {
    await model.getHomeDetailApiData(widget.vodId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _appBarValueNotifier.dispose();
    super.dispose();
  }
}
