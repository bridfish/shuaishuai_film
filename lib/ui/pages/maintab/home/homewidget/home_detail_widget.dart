import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/routes/routes.dart';
import 'package:shuaishuaimovie/ui/helper/home_detail_list_helper.dart';
import 'package:shuaishuaimovie/viewmodels/tab/home/home_detail_model.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

typedef Value2Changed<T> = void Function(T value, bool flag);

class SelectionBean {
  String name;
  String url;

  SelectionBean(this.name, this.url);
}

class HomeDetailBackGroundWidget extends StatelessWidget {
  final String imageUrl;

  const HomeDetailBackGroundWidget({Key key, @required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint("HomeDetailBackGroundWidget");
    return Stack(
      children: <Widget>[
        _contentBackgroundImage(context),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 2,
            color: AppColor.black.withOpacity(.3),
          ),
        ),
      ],
    );
  }

  Widget _contentBackgroundImage(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 2,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}

class MovieSelectionModuleWidget extends StatefulWidget {
  MovieSelectionModuleWidget(this.playUrls,
      {this.onAssembleTap, this.onSortTap, this.selectedIndex, this.isPositive = "0"});

  List<List> playUrls;
  int selectedIndex;
  String isPositive;
  Value2Changed onAssembleTap;
  ValueChanged onSortTap;

  @override
  _MovieSelectionModuleWidgetState createState() =>
      _MovieSelectionModuleWidgetState();
}

class _MovieSelectionModuleWidgetState
    extends State<MovieSelectionModuleWidget> {
  GlobalKey<_MovieSelectionListState> _selectionListKey;

  @override
  void initState() {
    super.initState();
    _selectionListKey = GlobalKey();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MovieSelectionTile(
          onSelectionCallBack: (value) {
            _selectionListKey.currentState.exchangeOtherWidget();
          },
          onSortCallBack: (value) {
            _selectionListKey.currentState.reversedSelection();
          },
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(
              Icons.play_circle_outline,
              color: AppColor.icon_yellow,
              size: 15,
            ),
            SizedBox(
              width: 2,
            ),
            CommonText(
              "帅帅视频",
              txtSize: 14,
              txtColor: AppColor.icon_yellow,
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          width: 80,
          height: 2,
          color: AppColor.icon_yellow,
        ),
        Container(
          height: 1,
          color: AppColor.lightGrey,
        ),
        SizedBox(
          height: 5,
        ),
        MovieSelectionList(
          key: _selectionListKey,
          playUrls: widget.playUrls,
          selectedIndex: widget.selectedIndex,
          onAssembleTap: widget.onAssembleTap,
          onSortTap: widget.onSortTap,
          isPositive: widget.isPositive,
        ),
      ],
    );
  }
}

class MovieSelectionTile extends StatefulWidget {
  //默认为false，正序。 true为倒序
  ValueChanged<bool> onSortCallBack;

  //默认为false, 收起状态， true为展开状态
  ValueChanged<bool> onSelectionCallBack;

  MovieSelectionTile({this.onSortCallBack, this.onSelectionCallBack});

  @override
  _MovieSelectionTileState createState() => _MovieSelectionTileState();
}

class _MovieSelectionTileState extends State<MovieSelectionTile>
    with TickerProviderStateMixin {
  AnimationController _selectionController;
  AnimationController _sortController;
  Animation _selectionAnimated;
  Animation _sortAnimated;
  ValueNotifier _selectionNotifer;
  var selectionStr;
  List<String> selectionStrs = ["展开全部剧集", "收起全部剧集"];

  @override
  void initState() {
    super.initState();
    _selectionController =
        AnimationController(duration: Duration(microseconds: 500), vsync: this);
    _sortController =
        AnimationController(duration: Duration(microseconds: 500), vsync: this);
    _selectionAnimated =
        Tween<double>(begin: 0, end: .5).animate(_selectionController);
    _sortAnimated = Tween<double>(begin: 0, end: .5).animate(_sortController);

    _selectionNotifer = ValueNotifier<int>(0);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CommonText(
          "播放列表",
          txtSize: 15,
          txtWeight: FontWeight.bold,
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            if (_selectionAnimated.isDismissed) {
              _selectionController.forward();
              widget.onSelectionCallBack(true);
              _selectionNotifer.value = 1;
            } else if (_selectionAnimated.isCompleted) {
              _selectionController.reverse();
              widget.onSelectionCallBack(false);
              _selectionNotifer.value = 0;
            }
          },
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                RotationTransition(
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColor.black,
                    size: 18,
                  ),
                  turns: _selectionAnimated,
                ),
                ValueListenableBuilder(
                  valueListenable: _selectionNotifer,
                  builder: (_, value, child) {
                    return CommonText(
                      selectionStrs[value],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 1,
          height: 12,
          color: AppColor.default_txt_grey,
        ),
        GestureDetector(
          onTap: () {
            if (_sortAnimated.isDismissed) {
              _sortController.forward();
              widget.onSortCallBack(true);
            } else if (_sortAnimated.isCompleted) {
              _sortController.reverse();
              widget.onSortCallBack(false);
            }
          },
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Row(
              children: <Widget>[
                RotationTransition(
                  child: Icon(
                    Icons.sort,
                    color: AppColor.black,
                    size: 18,
                  ),
                  turns: _sortAnimated,
                ),
                CommonText(
                  "排序",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _selectionController.dispose();
    _sortController.dispose();
    _selectionNotifer.dispose();
    super.dispose();
  }
}

class MovieSelectionList extends StatefulWidget {
  MovieSelectionList({
    Key key,
    @required this.playUrls,
    @required this.isPositive,
    this.onAssembleTap,
    this.onSortTap,
    this.selectedIndex,
  }) : super(key: key);

  List<List> playUrls;
  Value2Changed onAssembleTap;
  ValueChanged onSortTap;
  int selectedIndex;
  String isPositive;

  @override
  _MovieSelectionListState createState() => _MovieSelectionListState();
}

class _MovieSelectionListState extends State<MovieSelectionList> {
  CrossFadeState crossFadeState = CrossFadeState.showFirst;
  List<List> playUrls;
  bool isPositive = false;

  @override
  Widget build(BuildContext context) {
    isPositive = widget.isPositive == "0" ? false : true;
    playUrls =
        isPositive ? widget.playUrls?.reversed?.toList() : widget.playUrls;

    return playUrls == null || playUrls.length == 0
        ? Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: CommonText("非常抱歉，目前暂无数据,会尽快更新"),
          )
        : AnimatedCrossFade(
            crossFadeState: crossFadeState,
            firstChild: SizedBox(
              height: 35,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return _selectionBtnWidget(
                      SelectionBean(playUrls[index][0], playUrls[index][1]),
                      index);
                },
                itemCount: playUrls.length,
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 5,
                  );
                },
              ),
            ),
            secondChild: GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
                childAspectRatio: 100 / 35,
              ),
              itemBuilder: (context, index) {
                return _selectionBtnWidget(
                    SelectionBean(playUrls[index][0], playUrls[index][1]),
                    index);
              },
              itemCount: playUrls.length,
              physics: NeverScrollableScrollPhysics(),
            ),
            duration: Duration(microseconds: 300),
          );
  }

  Widget _selectionBtnWidget(SelectionBean selectionBean, int playUrlIndex) {
    return GestureDetector(
      onTap: () {
        widget.onAssembleTap(playUrlIndex, isPositive);
      },
      child: Container(
        alignment: Alignment.center,
        height: 35,
        constraints: BoxConstraints(
          maxWidth: 100,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: widget.selectedIndex == playUrlIndex
                ? AppColor.icon_yellow
                : Colors.grey[200],
            width: 1,
          ),
          color: Colors.grey[100],
        ),
        child: CommonText(
          selectionBean.name,
          txtColor: widget.selectedIndex == playUrlIndex
              ? AppColor.icon_yellow
              : AppColor.black,
        ),
      ),
    );
  }

  void exchangeOtherWidget() {
    setState(() {
      crossFadeState = crossFadeState == CrossFadeState.showFirst
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst;
    });
  }

  void reversedSelection() {
    setState(() {
      isPositive = !isPositive;
      widget.onSortTap(isPositive);
    });
  }
}

class RandModuleWidget extends StatelessWidget {
  RandModuleWidget(this.model);

  HomeDetailViewModel model;

  @override
  Widget build(BuildContext context) {
    debugPrint("RandModuleWidget");
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DetailListTile("猜你喜欢"),
        NarrowList(model.homeDetailBeanRands),
      ],
    );
  }
}

class RelateModuleWidget extends StatelessWidget {
  RelateModuleWidget(this.model);

  HomeDetailViewModel model;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        DetailListTile("相关推荐"),
        NarrowList(model.homeDetailBeanRelate),
      ],
    );
  }
}
