import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/home/homewidget/home_detail_widget.dart';
import 'package:shuaishuaimovie/ui/pages/video/widget/shuai_video.dart';
import 'package:shuaishuaimovie/viewmodels/video/video_model.dart';

class VideoPage extends StatefulWidget {
  VideoPage({
    @required this.videoId,
    @required this.videoUrl,
    @required this.videoName,
    @required this.videoLevel,
    @required this.playUrlType,
    @required this.playUrlIndex,
    @required this.isPositive,
    this.currentTime,
  });

  String videoId;
  String videoUrl;
  String playUrlType;
  int playUrlIndex;
  String videoName;
  String videoLevel;
  String currentTime;
  String isPositive;

  static const String BASE_VIDEO_URL = "https://vip1.sp-flv.com/p2p/?v=";

  @override
  State<StatefulWidget> createState() {
    return _VideoPageState();
  }
}

class _VideoPageState extends State<VideoPage> {
  @override
  void initState() {
    super.initState();
    //将videoUrl 解码
    widget.videoUrl = Uri.decodeComponent(widget.videoUrl);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Container(
          color: AppColor.white,
          child: ProviderWidget(
            initData: (model) {
              loadData(model);
            },
            model: VideoViewModel(
              videoId: widget.videoId,
              videoUrl: widget.videoUrl,
              playUrlType: widget.playUrlType,
              playUrlIndex: widget.playUrlIndex,
              videoName: widget.videoName,
              videoLevel: widget.videoLevel,
              currentTime: widget.currentTime,
              isPositive: widget.isPositive,
            ),
            builder:
                (BuildContext context, VideoViewModel model, Widget child) {
              return Column(
                children: <Widget>[
                  ShuaiVideo(model),
                  Expanded(child: _buildVideoSelectionContent(model)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildVideoSelectionContent(VideoViewModel model) {
    if (!model.isSuccess()) {
      return CommonViewStateHelper(
        model: model,
        onEmptyPressed: () => loadData(model),
        onErrorPressed: () => loadData(model),
        onNoNetworkPressed: () => loadData(model),
      );
    }
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: MovieSelectionModuleWidget(
          model.playUrls,
          selectedIndex: model.playUrlIndex,
          isPositive: model.isPositive,
          onAssembleTap: (index, isPositive) {
            model.changeVideo(index, isPositive);
          },
          onSortTap: (index, flag) {
            model.playUrlIndex = index;
            model.setPositive(flag ? "1" : "0");
          },
        ),
      ),
    );
  }

  Future<dynamic> loadData(VideoViewModel model) async {
    await model.getHomeDetailApiData(widget.videoId);
  }
}
