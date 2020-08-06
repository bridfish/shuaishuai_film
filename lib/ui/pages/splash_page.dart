import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animLeft;
  Animation<double> _animRight;
  Gradient _textGradient;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);

    Future.delayed(Duration(milliseconds: 300)).then((value) {
      _animationController.forward();
      Future.delayed(Duration(milliseconds: 2000)).then((value) {
        jumpIndex(context, replace: true);
      });
    });

    _textGradient = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [Colors.blue[300], Colors.blue]);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final offset = getTextWidth("帅帅影视") - getTextWidth("Flutter");
    final screenWidth = MediaQuery.of(context).size.width;
    _animLeft = Tween(begin: -screenWidth / 2 - offset / 2, end: 0.toDouble())
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeIn));
    _animRight = Tween(begin: screenWidth / 2 - offset / 2, end: 0.toDouble())
        .animate(CurvedAnimation(
            parent: _animationController, curve: Curves.easeIn));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Container(
        color: AppColor.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            if (_animLeft != null)
              AnimatedBuilder(
                animation: _animLeft,
                builder: (BuildContext context, Widget child) {
                  return Transform.translate(
                    offset: Offset(_animLeft.value, 0),
                    child: Text(
                      'Flutter',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                },
              ),
            SizedBox(
              width: 5,
            ),
            if (_animRight != null) _buildLogoTxt(),
          ],
        ),
      ),
    );
  }

  _buildLogoTxt() {
    return AnimatedBuilder(
      animation: _animRight,
      builder: (BuildContext context, Widget child) {
        return Transform.translate(
          offset: Offset(_animRight.value, 0),
          child: Text.rich(
            TextSpan(
              text: "帅帅",
              style: TextStyle(
                foreground: Paint()
                  ..shader =
                      _textGradient.createShader(Rect.fromLTRB(0, 0, 40, 40)),
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: "影视",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    foreground: Paint()..color = Colors.pink[400],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  double getTextWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: double.infinity);
    return textPainter.width;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
