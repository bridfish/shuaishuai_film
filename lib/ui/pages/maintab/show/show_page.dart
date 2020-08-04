import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/index_page.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/widget/common_tab_widget.dart';
import 'package:shuaishuaimovie/viewmodels/tab/commontab/common_tab_model.dart';

class ShowPage extends StatefulWidget {
  @override
  _ShowPageState createState() => _ShowPageState();
}

class _ShowPageState extends State<ShowPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<ShowTabModel>(
      initData: (model) {
        loadData(model);
      },
      model: ShowTabModel(),
      builder: (context, model, child) {
        if (!model.isSuccess()) {
          return CommonViewStateHelper(
            model: model,
            onEmptyPressed: () => loadData(model),
            onErrorPressed: () => loadData(model),
            onNoNetworkPressed: () => loadData(model),
          );
        }
        return CommonTabWidget(model, IndexPage.TAB_SHOW);
      },
    );
  }

  loadData(ShowTabModel model) {
    model.getCommonTabApiData();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
