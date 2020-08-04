import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/ui/pages/hot/widget/hot_rank_widget.dart';
import 'package:shuaishuaimovie/viewmodels/hot/hot_rank_model.dart';

class MonthRankPage extends StatefulWidget {
  @override
  _MonthRankPageState createState() => _MonthRankPageState();
}

class _MonthRankPageState extends State<MonthRankPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MonthRankModel>(
      model: MonthRankModel(),
      initData: (model) {
        loadData(model);
      },
      builder: (context, model, child) {
        if (!model.isSuccess()) {
          return CommonViewStateHelper(
            model: model,
            onEmptyPressed: () => loadData(model),
            onErrorPressed: () => loadData(model),
            onNoNetworkPressed: () => loadData(model),
          );
        }
        return _buildContent(model);
      },
    );
  }

  Widget _buildContent(model) {
    return HotRankModule(model);
  }

  void loadData(MonthRankModel model) {
    model.getRankApiData();
  }

  @override
  bool get wantKeepAlive => true;
}
