import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/widgets/tag_widget.dart';
import 'package:shuaishuaimovie/models/home_list_bean_entity.dart';
import 'package:shuaishuaimovie/ui/helper/common_list_helper.dart';

import 'common_list_helper.dart';

class HotListTile extends StatefulWidget {
  const HotListTile(this.title,
      {@required this.updateCount,
      this.iconData,
      this.onMorePressed,
      this.onRefreshPressed});

  final IconData iconData;
  final String title;
  final String updateCount;
  final VoidCallback onMorePressed;
  final VoidCallback onRefreshPressed;

  @override
  _HotListTileState createState() => _HotListTileState();
}

class _HotListTileState extends State<HotListTile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: 0, end: 2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      child: Row(
        children: <Widget>[
          buildListTileTitle(widget.iconData, widget.title),
          GestureDetector(
            onTap: widget.onMorePressed,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "今日更新",
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  movieYellowTag(widget.updateCount),
                ],
              ),
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              if (_controller.isAnimating) return;
              if (_controller.isDismissed || _controller.isCompleted) {
                _controller.reset();
                _controller.forward();
                widget.onRefreshPressed();
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RotationTransition(
                  turns: _animation,
                  child: Icon(
                    Icons.refresh,
                    color: AppColor.icon_yellow,
                    size: 15,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "换一换",
                  style: TextStyle(
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
