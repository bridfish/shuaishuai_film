import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/ui/helper/hot_update_list_helper.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/ui/pages/search/widget/search_widget.dart';
import 'package:shuaishuaimovie/viewmodels/hot/hot_update_model.dart';
import 'package:shuaishuaimovie/widgets/custom_refresh_widget.dart';

class TodayHotUpdatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("热播更新"),
        centerTitle: true,
        actions: <Widget>[
          JumpHeroTxtSearchIconWidget(),
        ],
      ),
      body: ProviderWidget<HotUpdateModel>(
        initData: (model) {
          loadData(model);
        },
        model: HotUpdateModel(),
        builder: (context, model, child) {
          if (!model.isSuccess()) {
            return CommonViewStateHelper(
              model: model,
              onEmptyPressed: () => loadData(model),
              onErrorPressed: () => loadData(model),
              onNoNetworkPressed: () => loadData(model),
            );
          }
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: _buildContent(model));
        },
      ),
    );
  }

  Widget _buildContent(HotUpdateModel model) {
    return CustomHeaderRefreshWidget(
      onRefresh: model.refreshHotUpdateData,
      easyRefreshController: model.easyRefreshController,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: HotUpdateTile(
            hotUpdateModel: model,
            onRefreshPress: () {
              model.refreshLocalData();
            },
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(top: 15),
          sliver: HotUpdateList(model.currentHotDatas),
        ),
      ],
    );
  }

  loadData(HotUpdateModel model) {
    model.getHotUpdateApiData();
  }
}
