import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/ui/pages/hot/rank/tab/month_rank_page.dart';
import 'package:shuaishuaimovie/ui/pages/hot/rank/tab/total_rank_page.dart';
import 'package:shuaishuaimovie/ui/pages/hot/rank/tab/week_rank_page.dart';
import 'package:shuaishuaimovie/ui/pages/search/widget/search_widget.dart';

class HotRankPage extends StatefulWidget {
  @override
  _HotRankPageState createState() => _HotRankPageState();
}

class _HotRankPageState extends State<HotRankPage> with SingleTickerProviderStateMixin {
  List tabs = ["周榜", "月榜", "总榜"];
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("排行榜"),
        centerTitle: true,
        actions: <Widget>[
          JumpHeroTxtSearchIconWidget(),
        ],
        bottom: TabBar(
          labelColor: AppColor.icon_yellow,
          unselectedLabelColor: AppColor.white,
          controller: _tabController,
          tabs: tabs.map((e) => Tab(text: e,)).toList(),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            WeekRankPage(),
            MonthRankPage(),
            TotalRankPage(),
          ],
        ),
      ),
    );
  }
}
