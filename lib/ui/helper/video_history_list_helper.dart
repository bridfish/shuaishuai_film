import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:shuaishuaimovie/database/bean/video_history_bean.dart'
    as videoHistory;
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/viewmodels/history/video_history_model.dart';
import 'package:shuaishuaimovie/widgets/custom_progress_paint.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class StickyHeaderList extends StatelessWidget {
  StickyHeaderList({this.title, this.sliver});

  String title;
  Widget sliver;

  @override
  Widget build(BuildContext context) {
    return SliverStickyHeader(
      header: Container(
        padding: EdgeInsets.only(top: 30, bottom: 15),
        color: AppColor.white,
        child: CommonText(
          title,
          txtSize: 16,
          txtWeight: FontWeight.bold,
        ),
      ),
      sliver: sliver,
    );
  }
}

class VideoHistoryList extends StatelessWidget {
  VideoHistoryList({
    this.model,
    this.list,
    this.animation,
    this.startIndex = 0,
    this.onCheckTap,
  });

  List<Map<String, dynamic>> list;
  Animation<double> animation;
  VideoHistoryModel model;
  int startIndex;
  VoidCallback onCheckTap;

  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        return SizedBox(
          height: 80,
          child: VideoHistoryItem(
            model: model,
            animation: animation,
            startIndex: startIndex + index,
            bean: list[index],
            onCheckTap: onCheckTap,
          ),
        );
      }, childCount: list.length),
    );
  }
}

class VideoHistoryItem extends StatefulWidget {
  VideoHistoryItem(
      {this.model,
      this.bean,
      this.animation,
      this.startIndex = 0,
      this.onCheckTap,});

  Map<String, dynamic> bean;
  Animation<double> animation;
  VideoHistoryModel model;
  int startIndex;
  VoidCallback onCheckTap;

  @override
  _VideoHistoryItemState createState() => _VideoHistoryItemState();
}

class _VideoHistoryItemState extends State<VideoHistoryItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (widget.model.isEdit) {
          setState(() {
            widget.model.operateCheckData(widget.startIndex,
                !widget.model.isHasCheckedData(widget.startIndex));
          });
          widget.onCheckTap();
        } else {
          //点击跳转
          var  bean = widget.model.getCurrentItem(widget.startIndex);
          jumpVideo(
            context,
            videoId: bean[videoHistory.columnVideoId].toString(),
            videoUrl: bean[videoHistory.columnVideoUrl],
            playUrlType: bean[videoHistory.columnPlayUrlType],
            playUrlIndex: bean[videoHistory.columnPlayUrlIndex].toString(),
            videoName: bean[videoHistory.columnVideoName],
            videoLevel: bean[videoHistory.columnVideoLevel],
          );

        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AnimatedBuilder(
            animation: widget.animation,
            builder: (_, __) {
              return Container(
                height: 70,
                alignment: Alignment.centerLeft,
                width: widget.animation.value,
                child: Icon(
                  IconData(0xe61e, fontFamily: "appIconFonts"),
                  color: widget.model.isHasCheckedData(widget.startIndex)
                      ? AppColor.icon_yellow
                      : AppColor.default_icon_grey,
                ),
              );
            },
          ),
          Container(
            height: 70,
            width: 110,
            child: Stack(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl: widget.bean[videoHistory.columnPicUrl],
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                  placeholder: (context, url) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  },
                  errorWidget: (context, url, error) {
                    return Center(
                      child: Icon(
                        Icons.error,
                        size: 30,
                        color: AppColor.icon_yellow,
                      ),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: CustomPaint(
                    size: Size(110, 3),
                    painter: CustomProgressPaint(
                        currentProgress: _currentRatio(widget.bean),
                        bgColor: AppColor.black.withOpacity(.3)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CommonText(
                  "${widget.bean[videoHistory.columnVideoName]}",
                  txtSize: 15,
                  txtWeight: FontWeight.bold,
                  maxLine: 1,
                ),
                CommonText(
                  "${widget.bean[videoHistory.columnUpdateInfo]}",
                  txtSize: 12,
                  maxLine: 1,
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      IconData(0xe608, fontFamily: "appIconFonts"),
                      size: 16,
                    ),
                    _watchTxt(widget.bean),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _watchTxt(Map<String, dynamic> map) {
    int ratio = _currentRatio(map);
    return ratio < 100 ? CommonText("观看至$ratio%") : CommonText("已完成");
  }

  int _currentRatio(Map<String, dynamic> map) {
    int currentPlayTime = map[videoHistory.columnCurrentPlayTime];
    int totalPlayTime = map[videoHistory.columnTotalPlayTime];
    //默认还剩下十秒代表播放完成
    if (currentPlayTime > totalPlayTime - 5 * 1000) return 100;
    return (currentPlayTime * 100 / totalPlayTime.toDouble()).floor();
  }
}
