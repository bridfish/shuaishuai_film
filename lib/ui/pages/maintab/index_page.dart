import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/home/home_page.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/movie/movie_page.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/show/show_page.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/teleplay/teleplay_page.dart';
import 'package:shuaishuaimovie/ui/pages/mine/mine_page.dart';
import 'package:shuaishuaimovie/viewmodels/tab/home/index_model.dart';
import 'package:shuaishuaimovie/widgets/app_bar.dart';

class IndexPage extends StatefulWidget {
  static const String TAB_HOME = "首页";
  static const String TAB_MOVIE = "电影";
  static const String TAB_SHOW = "综艺";
  static const String TAB_CARTOON = "动漫";
  static const String TAB_ME = "留言";
  static const String TAB_TELEPLAY = "连续剧";
  static const String CLASSES = "classes";

  IndexPage(this.currentTabName);

  String currentTabName;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final bottomBarItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.home), title: Text(IndexPage.TAB_HOME)),
    BottomNavigationBarItem(
        icon: Icon(IconData(0xe697, fontFamily: "appIconFonts")),
        title: Text(IndexPage.TAB_MOVIE)),
    BottomNavigationBarItem(
        icon: Icon(IconData(0xe6bc, fontFamily: "appIconFonts")),
        title: Text(IndexPage.TAB_TELEPLAY)),
    BottomNavigationBarItem(
        icon: Icon(IconData(0xe603, fontFamily: "appIconFonts")),
        title: Text(IndexPage.TAB_SHOW)),
    BottomNavigationBarItem(
        icon: Icon(IconData(0xe80b, fontFamily: "appIconFonts")),
        title: Text(IndexPage.TAB_ME)),
  ];

  var _pageController = PageController();

  List<Widget> _list = List();
  DateTime _lastPressed;

  @override
  void initState() {
    super.initState();

    _list
      ..add(HomePage())
      ..add(MoviePage())
      ..add(TeleplayPage())
      ..add(ShowPage())
      ..add(MinePage());
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<IndexModel>(
      initData: (model) {
        switch (widget.currentTabName) {
          case IndexPage.TAB_HOME:
            model.navBarCurrentIndex = 0;
            break;
          case IndexPage.TAB_MOVIE:
            model.navBarCurrentIndex = 1;
            break;
          case IndexPage.TAB_TELEPLAY:
            model.navBarCurrentIndex = 2;
            break;
          case IndexPage.TAB_SHOW:
            model.navBarCurrentIndex = 3;
            break;
          case IndexPage.TAB_ME:
            model.navBarCurrentIndex = 4;
            break;
        }
      },
      model: IndexModel(_pageController),
      builder: (BuildContext context, IndexModel model, Widget child) {
        return Scaffold(
          backgroundColor: AppColor.black,
          appBar: model.isShowIndexAppBar
              ? CustomAppBar(
                  contentHeight: 50,
                  backgroundColor: Colors.white,
                )
              : null,
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: model.navBarCurrentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              model.setNavBarCurrentIndex(index);
            },
            items: bottomBarItems,
          ),
          body: WillPopScope(
            onWillPop: () async {
              if (_lastPressed == null ||
                  DateTime.now().difference(_lastPressed) >
                      Duration(seconds: 1)) {
                //两次点击间隔超过1秒则重新计时
                Fluttertoast.showToast(msg: "再一次点击返回");
                _lastPressed = DateTime.now();
                return false;
              }
              return true;
            },
            child: Container(
                color: AppColor.white, child: _buildIndexContent(model)),
          ),
        );
      },
      child: CustomAppBar(
        contentHeight: 50,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildIndexContent(model) {
    return PageView.builder(
      itemBuilder: (ctx, index) => _list[index],
      itemCount: _list.length,
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
