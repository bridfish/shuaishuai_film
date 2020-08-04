import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/utils/str_util.dart';
import 'package:shuaishuaimovie/utils/time/movie_time_util.dart';
import 'package:shuaishuaimovie/viewmodels/hot/hot_update_model.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class HotUpdateTile extends StatefulWidget {
  HotUpdateTile({@required this.hotUpdateModel, @required this.onRefreshPress});
  VoidCallback onRefreshPress;
  HotUpdateModel hotUpdateModel;
  @override
  _HotUpdateTileState createState() => _HotUpdateTileState();
}

class _HotUpdateTileState extends State<HotUpdateTile> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: 0, end: 2).animate(_controller);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey[200], width: 1)),
      ),
      child: Row(
        children: <Widget>[
          CommonText(
            "今日更新",
            txtSize: 16,
            txtWeight: FontWeight.bold,
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              if(_controller.isAnimating) return;
              if(_controller.isCompleted || _controller.isDismissed) {
                _controller.reset();
                _controller.forward();
                widget.onRefreshPress();
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: <Widget>[
                  RotationTransition(
                    turns: _animation,
                    child: Icon(
                      Icons.refresh,
                      size: 15,
                      color: AppColor.icon_yellow,
                    ),
                  ),
                  CommonText(
                    "换一换",
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  CommonText(
                    "${widget.hotUpdateModel.currentPage + 1}/${widget.hotUpdateModel.hotUpdateTotals}",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.opacity,
                  size: 15,
                ),
                CommonText("筛选"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class HotUpdateList extends StatefulWidget {
  HotUpdateList(this.list);

  List<CommonItemBean> list;

  @override
  _HotUpdateListState createState() => _HotUpdateListState();
}

class _HotUpdateListState extends State<HotUpdateList> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          if (index < widget.list.length - 2) {
            return Column(
              children: <Widget>[
                _buildHotUpdateItem(widget.list[index]),
                _separatedDivider(),
              ],
            );
          } else {
            return _buildHotUpdateItem(widget.list[index]);
          }
        },
        childCount: widget.list.length,
      ),
    );
  }

  Widget _buildHotUpdateItem(CommonItemBean commonItemBean) {
    return GestureDetector(
      onTap: () {
        jumpHomeDetail(context, commonItemBean.vodID.toString(), commonItemBean.vodPic);
      },
      child: Container(
        color: AppColor.white,
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: CachedNetworkImage(
                height: 100,
                width: 280 / 360 * 100,
                imageUrl: commonItemBean.vodPic,
                fit: BoxFit.cover,
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
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            child: CommonText(
                              commonItemBean.vodName,
                              txtSize: 14,
                              maxLine: 1,
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        CommonText(
                          commonItemBean.vodClass.typeName,
                          txtColor: AppColor.default_txt_grey,
                          txtSize: 12,
                        ),
                        CommonText(
                          " / ",
                          txtColor: AppColor.default_txt_grey,
                          txtSize: 12,
                        ),
                        CommonText(
                          MovieTimeUtil.getVodTime(commonItemBean.vodTime),
                          txtColor: AppColor.icon_yellow,
                          txtSize: 12,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    if (StrUtil.isNotEmpty(commonItemBean.vodActor))
                      CommonText(
                        commonItemBean.vodActor,
                        txtColor: AppColor.default_txt_grey,
                        maxLine: 1,
                      ),
                    if (StrUtil.isNotEmpty(commonItemBean.vodRemarks))
                      CommonText(
                        "状态: ${commonItemBean.vodRemarks}",
                        txtColor: AppColor.default_txt_grey,
                        maxLine: 1,
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

  Widget _separatedDivider() {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Container(
            height: 1,
            color: AppColor.line_grey,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
