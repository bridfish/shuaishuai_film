import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/index_page.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/widget/common_tab_widget.dart';
import 'package:shuaishuaimovie/ui/pages/search/txt_search_page.dart';
import 'package:shuaishuaimovie/ui/pages/search/widget/search_widget.dart';
import 'package:shuaishuaimovie/viewmodels/tab/commontab/common_tab_model.dart';

class CartoonPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("动漫剧场"),
        actions: <Widget>[
          JumpHeroTxtSearchIconWidget(),
        ],
      ),
      body: ProviderWidget<CartoonModel>(
        initData: (model) {
          loadData(model);
        },
        model: CartoonModel(),
        builder: (context, model, child) {
          if (!model.isSuccess()) {
            return CommonViewStateHelper(
              model: model,
              onEmptyPressed: () => loadData(model),
              onErrorPressed: () => loadData(model),
              onNoNetworkPressed: () => loadData(model),
            );
          }
          return CommonTabWidget(model, IndexPage.TAB_CARTOON);
        },
      ),
    );
  }

  loadData(CartoonModel model) {
    model.getCommonTabApiData();
  }
}
