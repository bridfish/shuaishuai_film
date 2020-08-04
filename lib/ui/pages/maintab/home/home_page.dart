import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/home/homewidget/home_list_widget.dart';
import 'package:shuaishuaimovie/viewmodels/tab/home/home_model.dart';
import 'package:shuaishuaimovie/widgets/custom_refresh_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel>(
      initData: (model) {
        loadData(model);
      },
      model: HomeViewModel(),
      child: HomeContentHeaderWidget(),
      builder: (context, model, child) {
        if (!model.isSuccess()) {
          return CommonViewStateHelper(
            model: model,
            onEmptyPressed: () => loadData(model),
            onErrorPressed: () => loadData(model),
            onNoNetworkPressed: () => loadData(model),
          );
        }

        return CustomHeaderRefreshWidget(
          onRefresh: model.refreshHomeListData,
          easyRefreshController: model.easyRefreshController,
          slivers: <Widget>[
            SliverToBoxAdapter(
              child: child,
            ),
            SliverHomeHotModuleWidget(model),
            SliverHomeMovieModuleWidget(model),
            SliverHomeSitcomModuleWidget(model),
            SliverHomeVarietyModuleWidget(model),
            SliverHomeAnimatedModuleWidget(model),
          ],
        );
      },
    );
  }

  loadData(HomeViewModel model) {
    model.getHomeListApiData();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
