import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

typedef OnRefreshCallback = Future<void> Function();
typedef OnLoadMoreCallback = Future<void> Function();

class HeaderRefreshWidget extends StatelessWidget {
  HeaderRefreshWidget(
      {@required this.child,
      @required this.onRefresh,
      @required this.easyRefreshController});

  Widget child;
  OnRefreshCallback onRefresh;
  EasyRefreshController easyRefreshController;

  @override
  Widget build(BuildContext context) {
    debugPrint("build_header_refresh");
    return CommonRefreshWidget(
        child: child,
        easyRefreshController: easyRefreshController,
        onRefresh: onRefresh,
        enableRefresh: true);
  }
}

class FooterLoadMoreWidget extends StatelessWidget {
  FooterLoadMoreWidget(
      {@required this.child,
      @required this.onLoadMore,
      @required this.easyRefreshController,
      this.topBouncing = true,
      this.bottomBouncing = true});

  Widget child;
  OnLoadMoreCallback onLoadMore;
  EasyRefreshController easyRefreshController;
  bool topBouncing;
  bool bottomBouncing;

  @override
  Widget build(BuildContext context) {
    debugPrint("build_footer_onLoad");
    return CommonRefreshWidget(
      child: child,
      easyRefreshController: easyRefreshController,
      onLoadMore: onLoadMore,
      enableLoad: true,
      bottomBouncing: bottomBouncing,
      topBouncing: topBouncing,
    );
  }
}

class CommonRefreshWidget extends StatefulWidget {
  CommonRefreshWidget({
    @required this.child,
    @required this.easyRefreshController,
    this.onRefresh,
    this.onLoadMore,
    this.enableRefresh = false,
    this.enableLoad = false,
    this.topBouncing = true,
    this.bottomBouncing = true,
  });

  Widget child;
  bool enableRefresh;
  bool enableLoad;
  bool topBouncing;
  bool bottomBouncing;
  int count;
  OnRefreshCallback onRefresh;
  OnLoadMoreCallback onLoadMore;
  EasyRefreshController easyRefreshController;

  @override
  _CommonRefreshWidgetState createState() => _CommonRefreshWidgetState();
}

class _CommonRefreshWidgetState extends State<CommonRefreshWidget> {
  _CommonRefreshWidgetState();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      enableControlFinishRefresh: true,
      enableControlFinishLoad: true,
      controller: widget.easyRefreshController,
      topBouncing: widget.topBouncing,
      bottomBouncing: widget.bottomBouncing,
      header: widget.enableRefresh
          ? ClassicalHeader(
              enableInfiniteRefresh: false,
              infoColor: Colors.black87,
              refreshText: "下拉刷新...",
              refreshReadyText: "释放即可刷新...",
              refreshingText: "加载中...",
              refreshedText: "加载成功...",
              refreshFailedText: "加载失败...",
              noMoreText: "没有更多数据了...",
              infoText: "更新时间: ${getCurrentTime()}",
            )
          : null,
      footer: widget.enableLoad
          ? ClassicalFooter(
              loadText: "加载中...",
              loadReadyText: "加载中...",
              loadingText: "加载中...",
              loadedText: "加载成功...",
              loadFailedText: "加载失败...",
              noMoreText: "没有更多数据了...",
              infoText: "更新时间: ${getCurrentTime()}",
            )
          : null,
      onRefresh: widget.enableRefresh ? widget.onRefresh : null,
      onLoad: widget.enableLoad ? widget.onLoadMore : null,
      child: widget.child,
    );
  }

  String getCurrentTime() {
    var now = DateTime.now();
    return formatDate(now, [hh, ':', nn]);
  }
}
