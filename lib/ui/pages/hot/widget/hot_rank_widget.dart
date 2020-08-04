import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/ui/helper/hot_rank_list_helper.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/index_page.dart';
import 'package:shuaishuaimovie/viewmodels/hot/hot_rank_model.dart';
import 'package:shuaishuaimovie/widgets/custom_refresh_widget.dart';

class HotRankModule extends StatelessWidget {
  HotRankModule(this.model);

  HotRankModel model;

  @override
  Widget build(BuildContext context) {
    return CustomHeaderRefreshWidget(
      onRefresh: () async {
        await model.refreshRankData();
      },
      easyRefreshController: model.easyRefreshController,
      slivers: <Widget>[
        SliverToBoxAdapter(
            child: HotRankHeaderTile(
          IndexPage.TAB_MOVIE,
          onMorePress: () {
            jumpIndex(context, type: IndexPage.TAB_MOVIE, clearStack: true);
          },
        )),
        SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 10),
            sliver: CommonSliverHotRankList(model.hotRankBeanEntity.movie)),
        SliverToBoxAdapter(
            child: HotRankHeaderTile(
          IndexPage.TAB_TELEPLAY,
          onMorePress: () {
            jumpIndex(context, type: IndexPage.TAB_TELEPLAY, clearStack: true);
          },
        )),
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 10),
          sliver: CommonSliverHotRankList(model.hotRankBeanEntity.teleplay),
        ),
        SliverToBoxAdapter(
            child: HotRankHeaderTile(
          IndexPage.TAB_SHOW,
          onMorePress: () {
            jumpIndex(context, type: IndexPage.TAB_SHOW, clearStack: true);
          },
        )),
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 10),
          sliver: CommonSliverHotRankList(model.hotRankBeanEntity.show),
        ),
        SliverToBoxAdapter(
            child: HotRankHeaderTile(
          IndexPage.TAB_CARTOON,
          onMorePress: () {
            jumpCartoon(context);
          },
        )),
        SliverPadding(
          padding: EdgeInsets.symmetric(vertical: 10),
          sliver: CommonSliverHotRankList(model.hotRankBeanEntity.cartoon),
        ),
      ],
    );
  }
}
