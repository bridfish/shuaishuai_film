import 'dart:async';

import 'package:flutter/material.dart';

class SmarqueeWidget extends StatefulWidget {
  SmarqueeWidget(
      {@required this.child,
      this.marginLeft,
      this.betweenSpacing,
      this.width = double.infinity,
      this.speedRate = 1});

  /// marginLeft代表着第一个文字控件距离最左边的距离
  /// *默认的宽度是控件的宽度
  double marginLeft;

  ///betweenSpacing 代表文字控件之间的间距
  /// *默认的宽度是控件的宽度
  double betweenSpacing;

  //子控件
  final Widget child;

  final double width;

  final double speedRate;

  @override
  _SmarqueeWidgetState createState() => _SmarqueeWidgetState();
}

class _SmarqueeWidgetState extends State<SmarqueeWidget> {
  static const double NORMAL_SPEED = 150.0;

  Timer _smarqueeTimer;
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startTimer();
    });
  }

  void startTimer() {
    _smarqueeTimer = Timer.periodic(Duration(microseconds: 16), (timer) {
      final distance = _scrollController.offset ?? 0;
      if(_scrollController.hasClients)
      _scrollController.jumpTo(distance + (1 / NORMAL_SPEED) * widget.speedRate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScrollNotificationInterceptor(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          debugPrint("build_layout_smarquee_widget");
          final biggestWidth = constraints.biggest.width;
          widget.marginLeft ??= biggestWidth;
          widget.betweenSpacing ??= biggestWidth;

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: double.maxFinite.toInt(),
            itemBuilder: (context, index) {
              final distance =
                  (index == 0 ? widget.marginLeft : widget.betweenSpacing);
              return Container(
                padding: EdgeInsets.only(left: distance),
                alignment: Alignment.center,
                child: widget.child,
              );
            },
            controller: _scrollController,
            physics: NeverScrollableScrollPhysics(),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _smarqueeTimer.cancel();
    _scrollController.dispose();
    super.dispose();
  }
}

/// 滚动通知拦截器(用于拦截其他UI组件的滑动事件)
/// 由于一些需求在父组件里进行scrollNotification的监听操作，
/// 而SMarqueeWidget会影响到父组件的逻辑。
/// 例如：本项目集成了EasyRefresh库，会影响到它的下拉刷新功能。
/// 因此额外做了阻止SmarqueeWidget的滚动事件向上传递。
class ScrollNotificationInterceptor extends StatelessWidget {
  final Widget child;

  // 构造函数
  ScrollNotificationInterceptor({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (ScrollNotification notification) {
        return true;
      },
      child: this.child,
    );
  }
}