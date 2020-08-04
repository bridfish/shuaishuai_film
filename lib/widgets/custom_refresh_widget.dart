import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

typedef OnRefreshCallback = Future<void> Function();
typedef OnLoadMoreCallback = Future<void> Function();

class CustomHeaderRefreshWidget extends StatelessWidget {
  CustomHeaderRefreshWidget({@required this.slivers, @required this.onRefresh, @required this.easyRefreshController});
  List<Widget> slivers;
  OnRefreshCallback onRefresh;
  EasyRefreshController easyRefreshController;


  @override
  Widget build(BuildContext context) {
    debugPrint("build_header_refresh");
    return CustomCommonRefreshWidget(slivers: slivers, easyRefreshController: easyRefreshController, onRefresh: onRefresh, enableRefresh: true);
  }
}

class CustomFooterLoadMoreWidget extends StatelessWidget {
  CustomFooterLoadMoreWidget({@required this.slivers, @required this.onLoadMore, @required this.easyRefreshController, });
  List<Widget> slivers;
  OnLoadMoreCallback onLoadMore;
  EasyRefreshController easyRefreshController;


  @override
  Widget build(BuildContext context) {
    debugPrint("build_footer_onLoad");
    return CustomCommonRefreshWidget(slivers: slivers, easyRefreshController: easyRefreshController, onLoadMore: onLoadMore, enableLoad: true,);
  }
}

class CustomCommonRefreshWidget extends StatefulWidget {
  CustomCommonRefreshWidget({@required this.slivers, @required this.easyRefreshController, this.onRefresh, this.onLoadMore, this.enableRefresh = false, this.enableLoad = false});
  List<Widget> slivers;
  bool enableRefresh;
  bool enableLoad;
  int count;
  OnRefreshCallback onRefresh;
  OnLoadMoreCallback onLoadMore;
  EasyRefreshController easyRefreshController;

  @override
  _CustomCommonRefreshWidgetState createState() => _CustomCommonRefreshWidgetState();
}

class _CustomCommonRefreshWidgetState extends State<CustomCommonRefreshWidget> {
  _CustomCommonRefreshWidgetState();
  // 反向
  bool _reverse = false;
  // 方向
  Axis _direction = Axis.vertical;
  // Header浮动
  bool _headerFloat = false;
  // 无限加载
  bool _enableInfiniteLoad = true;
  // 控制结束
  bool _enableControlFinish = false;
  // 任务独立
  bool _taskIndependence = false;
  // 震动
  bool _vibration = true;
  // 是否开启刷新
  bool _enableRefresh = true;
  // 是否开启加载
  bool _enableLoad = true;
  // 顶部回弹
  bool _topBouncing = true;
  // 底部回弹
  bool _bottomBouncing = true;

  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

  }
  @override
  Widget build(BuildContext context) {

    return EasyRefresh.custom(
        enableControlFinishRefresh: true,
        enableControlFinishLoad: true,
        taskIndependence: _taskIndependence,
        controller: widget.easyRefreshController,
        scrollController: _scrollController,
        reverse: _reverse,
        scrollDirection: _direction,
        topBouncing: _topBouncing,
        bottomBouncing: _bottomBouncing,
        header: widget.enableRefresh ? ClassicalHeader(
          enableInfiniteRefresh: false,
          bgColor: _headerFloat ? Theme.of(context).primaryColor : null,
          infoColor: _headerFloat ? Colors.black87 : Colors.teal,
          float: _headerFloat,
          enableHapticFeedback: _vibration,
          refreshText: "下拉刷新...",
          refreshReadyText: "释放即可刷新...",
          refreshingText: "加载中...",
          refreshedText: "加载成功...",
          refreshFailedText: "加载失败...",
          noMoreText: "没有更多数据了...",
          infoText: "更新时间: ${getCurrentTime()}",
        ) : null,
        footer: widget.enableLoad ? ClassicalFooter(
          enableInfiniteLoad: _enableInfiniteLoad,
          enableHapticFeedback: _vibration,
          loadText: "加载中...",
          loadReadyText: "加载中...",
          loadingText: "加载中...",
          loadedText: "加载成功...",
          loadFailedText: "加载失败...",
          noMoreText: "没有更多数据了...",
          infoText: "更新时间: ${getCurrentTime()}",
        ) : null,
        onRefresh: widget.enableRefresh ? widget.onRefresh: null,
        onLoad: widget.enableLoad ? widget.onLoadMore : null,
        slivers: widget.slivers,);
  }

  String getCurrentTime() {
    var now = DateTime.now();
    return formatDate(now, [hh, ':', nn]);
  }
}



