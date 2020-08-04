import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/widgets/toggle_rotate.dart';

class IntroducePanelWidget extends StatefulWidget {
  final String content;

  const IntroducePanelWidget({Key key, this.content}) : super(key: key);
  @override
  _IntroducePanelWidgetState createState() => _IntroducePanelWidgetState();
}

class _IntroducePanelWidgetState extends State<IntroducePanelWidget> {
  CrossFadeState _crossFadeState = CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _introducePlot(),
        _buildShowIntroducePlotBtn(),
      ],
    );
  }

  Widget _introducePlot() {
    return AnimatedCrossFade(
      crossFadeState: _crossFadeState,
      firstChild: Text(
        widget.content,
        maxLines: 2,
        overflow: TextOverflow.fade,
      ),
      secondChild: Text(widget.content),
      duration: Duration(microseconds: 500),
    );
  }

  Widget _buildShowIntroducePlotBtn() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: ToggleRotate(
        durationMs: 300,
        onTap: () => _toggleIntroducePlotPanel(),
        child: Icon(Icons.keyboard_arrow_down, color: AppColor.black,),
      ),
    );
  }

  void _toggleIntroducePlotPanel() {
    setState(() {
      _crossFadeState = _crossFadeState == CrossFadeState.showFirst
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst;
    });
  }
}
