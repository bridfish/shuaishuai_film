import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';

class CheckIcon extends StatefulWidget {
  bool value;
  ValueChanged<bool> onChanged;
  IconData iconData;
  Color checkColor;
  Color activeColor;

  CheckIcon({
    @required this.value,
    @required this.iconData,
    this.onChanged,
    this.activeColor,
    this.checkColor,
  });

  @override
  _CheckIconState createState() => _CheckIconState();
}

class _CheckIconState extends State<CheckIcon> {
  @override
  Widget build(BuildContext context) {
    widget.checkColor = widget.checkColor ?? AppColor.default_txt_grey;
    widget.activeColor = widget.activeColor ?? Theme.of(context).accentColor;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          widget.value = !widget.value;
          print(widget.value);
          if (widget.onChanged != null) widget.onChanged(widget.value);
        });
      },
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Icon(
          widget.iconData,
          size: 20,
          color: widget.value ? widget.activeColor : widget.checkColor,
        ),
      ),
    );
  }
}
