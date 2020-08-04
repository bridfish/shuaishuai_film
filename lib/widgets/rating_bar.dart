import 'package:flutter/material.dart';

class StarRatingBar extends StatefulWidget {
  final double starSize;
  final int startCount;
  final int selectedCount;
  final double starSpace;
  final Color defaultStarColor;
  final Color selectedStarColor;

  const StarRatingBar.onlyShow({
    Key key,
    this.starSize = 15,
    this.startCount = 5,
    this.starSpace = 2,
    this.selectedCount = 0,
    this.defaultStarColor = Colors.grey,
    this.selectedStarColor = Colors.red,
  }) : super(key: key);

  @override
  _StarRatingBarState createState() => _StarRatingBarState();
}

class _StarRatingBarState extends State<StarRatingBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ..._buildStarList(),
      ],
    );
  }

  List<Widget> _buildStarList() {
    var starList = List<Widget>();
    for (int i = 0; i < widget.startCount; i++) {
      Color starColor = i < widget.selectedCount
          ? widget.selectedStarColor
          : widget.defaultStarColor;
      starList.add(_buildStar(starColor));
      if (i != widget.startCount - 1)
        starList.add(SizedBox(
          width: widget.starSpace,
        ));
    }
    return starList;
  }

  Widget _buildStar(Color color) {
    return Icon(
      Icons.star,
      size: widget.starSize,
      color: color,
    );
  }
}
