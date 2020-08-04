import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/routes/routes.dart';
import 'package:shuaishuaimovie/shuai_movie.dart';
import 'package:shuaishuaimovie/ui/helper/common_list_helper.dart';
import 'package:shuaishuaimovie/ui/helper/home_list_helper.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/index_page.dart';
import 'package:shuaishuaimovie/viewmodels/tab/home/home_model.dart';
import 'package:shuaishuaimovie/viewmodels/tab/home/index_model.dart';
import 'package:shuaishuaimovie/widgets/smarquee_widget.dart';

class HomeContentHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HomeMovieModuleWidget(),
        HomeNotificationWidget(),
      ],
    );
  }
}

class HomeMovieModuleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Flex(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        direction: Axis.horizontal,
        children: <Widget>[
          _buildMovieModuleItem(
              Icons.movie,
              [Colors.blue[600], Colors.blue[300]],
              "电影",
              context,
              IndexPage.TAB_MOVIE),
          _buildMovieModuleItem(Icons.tv, [Colors.red[600], Colors.red[300]],
              "连续剧", context, IndexPage.TAB_TELEPLAY),
          _buildMovieModuleItem(
              Icons.color_lens,
              [Colors.deepPurpleAccent[400], Colors.deepPurpleAccent[200]],
              "综艺",
              context,
              IndexPage.TAB_SHOW),
          _buildMovieModuleItem(
              Icons.child_care,
              [Colors.green[600], Colors.green[300]],
              "动漫",
              context,
              IndexPage.TAB_CARTOON),
        ],
      ),
    );
  }

  Widget _buildMovieModuleItem(IconData iconData, List<Color> colors,
      String title, BuildContext context, String type) {
    return GestureDetector(
      onTap: () {
        switch (type) {
          case IndexPage.TAB_MOVIE:
            Provider.of<IndexModel>(context, listen: false)
                .setNavBarCurrentIndex(1);
            break;
          case IndexPage.TAB_TELEPLAY:
            Provider.of<IndexModel>(context, listen: false)
                .setNavBarCurrentIndex(2);
            break;
          case IndexPage.TAB_SHOW:
            Provider.of<IndexModel>(context, listen: false)
                .setNavBarCurrentIndex(3);
            break;
          default:
            jumpCartoon(context);
            break;
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 45,
            height: 45,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: colors),
            ),
            child: Icon(
              iconData,
              color: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Text(title),
          ),
        ],
      ),
    );
  }
}

class HomeNotificationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.grey[200],
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 5),
            child: Icon(
              IconData(0xe6a0, fontFamily: "appIconFonts"),
              size: 17,
              color: AppColor.icon_yellow,
            ),
          ),
          Expanded(
            child: SmarqueeWidget(
              child: Text("帅帅影视欢迎您的到来，如有观看问题请点击留言按钮联系我们"),
            ),
          ),
        ],
      ),
    );
  }
}

class SliverHomeHotModuleWidget extends StatefulWidget {
  SliverHomeHotModuleWidget(this.model);

  HomeViewModel model;

  @override
  _SliverHomeHotModuleWidgetState createState() =>
      _SliverHomeHotModuleWidgetState();
}

class _SliverHomeHotModuleWidgetState extends State<SliverHomeHotModuleWidget> {
  List<CommonItemBean> _currentHotPageDatas;
  ValueNotifier _currentHotDataNotifier;

  @override
  void initState() {
    super.initState();
    _currentHotDataNotifier = ValueNotifier<int>(0);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.model.isRequestApi) {
      getCurrentHotPageData(0);
      widget.model.setRequestApi(false);
    }

    return ValueListenableBuilder(
      valueListenable: _currentHotDataNotifier,
      builder: (_, value, child) {
        return SliverToBoxAdapter(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              child,
              CommonGrid(_currentHotPageDatas),
            ],
          ),
        );
      },
      child: HotListTile(
        "本周热播",
        updateCount: widget.model.homeListBeanEntity.lastQty.toString(),
        iconData: Icons.message,
        onMorePressed: () {
          Application.router.navigateTo(context, Routes.hot_update);
        },
        onRefreshPressed: () =>
            refreshCurrentHotPageData(_currentHotDataNotifier.value),
      ),
    );
  }

  void refreshCurrentHotPageData(int index) {
    int hotGroup = widget.model.homeHotBeans.length ~/ 6;
    getCurrentHotPageData(index);
    _currentHotDataNotifier.value = index >= hotGroup - 1 ? 0 : index + 1;
  }

  void getCurrentHotPageData(int index) {
    var tempHotPageDatas = List<CommonItemBean>();
    tempHotPageDatas.addAll(widget.model.homeHotBeans);
    _currentHotPageDatas = tempHotPageDatas.sublist(index * 6, index * 6 + 6);
  }

  @override
  void dispose() {
    _currentHotDataNotifier.dispose();
    super.dispose();
  }
}

class SliverHomeMovieModuleWidget extends StatelessWidget {
  SliverHomeMovieModuleWidget(this.model);

  HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          CommonListTile(
            "最新电影",
            iconData: Icons.message,
            onMorePressed: (_) {
              Provider.of<IndexModel>(context, listen: false)
                  .setNavBarCurrentIndex(1);
            },
          ),
          CommonGrid(model.homeMovieBeans),
        ],
      ),
    );
  }
}

class SliverHomeSitcomModuleWidget extends StatelessWidget {
  SliverHomeSitcomModuleWidget(this.model);

  HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          CommonListTile(
            "最新连续剧",
            iconData: Icons.message,
            onMorePressed: (_) {
              Provider.of<IndexModel>(context, listen: false)
                  .setNavBarCurrentIndex(2);
            },
          ),
          CommonGrid(model.homeSitcomBeans),
        ],
      ),
    );
  }
}

class SliverHomeVarietyModuleWidget extends StatelessWidget {
  SliverHomeVarietyModuleWidget(this.model);

  HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          CommonListTile(
            "最新综艺",
            iconData: Icons.message,
            onMorePressed: (_) {
              Provider.of<IndexModel>(context, listen: false)
                  .setNavBarCurrentIndex(3);
            },
          ),
          CommonGrid(model.homeVarietyBeans),
        ],
      ),
    );
  }
}

class SliverHomeAnimatedModuleWidget extends StatelessWidget {
  SliverHomeAnimatedModuleWidget(this.model);

  HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          CommonListTile(
            "最新动漫",
            iconData: Icons.message,
            onMorePressed: (_) {
              jumpCartoon(context);
            },
          ),
          CommonGrid(model.homeAnimatedBeans),
        ],
      ),
    );
  }
}
