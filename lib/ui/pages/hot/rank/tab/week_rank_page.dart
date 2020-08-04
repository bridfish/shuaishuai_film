import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/ui/pages/hot/widget/hot_rank_widget.dart';
import 'package:shuaishuaimovie/viewmodels/hot/hot_rank_model.dart';

class WeekRankPage extends StatefulWidget {
  @override
  _WeekRankPageState createState() => _WeekRankPageState();
}

class _WeekRankPageState extends State<WeekRankPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<WeekRankModel>(
      model: WeekRankModel(),
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

  void loadData(WeekRankModel model) {
    model.getRankApiData();

  }

  @override
  bool get wantKeepAlive => true;
}
