import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/index_page.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/widget/common_tab_widget.dart';
import 'package:shuaishuaimovie/viewmodels/tab/commontab/common_tab_model.dart';

class MoviePage extends StatefulWidget {
  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return ProviderWidget<MovieTabModel>(
      initData: (model) {
        loadData(model);
      },
      model: MovieTabModel(),
      builder: (context, model, child) {
        if (!model.isSuccess()) {
          return CommonViewStateHelper(
            model: model,
            onEmptyPressed: () => loadData(model),
            onErrorPressed: () => loadData(model),
            onNoNetworkPressed: () => loadData(model),
          );
        }
        return CommonTabWidget(model, IndexPage.TAB_MOVIE);
      },
    );
  }

  loadData(MovieTabModel model) {
    model.getCommonTabApiData();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
