import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/index_page.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/widget/common_tab_widget.dart';
import 'package:shuaishuaimovie/viewmodels/tab/commontab/common_tab_model.dart';

class TeleplayPage extends StatefulWidget {
  @override
  _TeleplayPageState createState() => _TeleplayPageState();
}

class _TeleplayPageState extends State<TeleplayPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TeleplayTabModel>(
      initData: (model) {
        loadData(model);
      },
      model: TeleplayTabModel(),
      builder: (context, model, child) {
        if (!model.isSuccess()) {
          return CommonViewStateHelper(
            model: model,
            onEmptyPressed: () => loadData(model),
            onErrorPressed: () => loadData(model),
            onNoNetworkPressed: () => loadData(model),
          );
        }
        return CommonTabWidget(model, IndexPage.TAB_TELEPLAY);
      },
    );
  }

  loadData(TeleplayTabModel model) {
    model.getCommonTabApiData();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
