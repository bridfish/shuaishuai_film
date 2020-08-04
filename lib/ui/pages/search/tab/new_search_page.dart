import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/ui/helper/common_list_helper.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/viewmodels/search/condition_search_model.dart';
import 'package:shuaishuaimovie/viewmodels/search/select_condition_model.dart';
import 'package:shuaishuaimovie/widgets/refresh_widget.dart';

class NewSearchPage extends StatefulWidget {
  NewSearchPage({Key key, this.model, this.tabType}) : super(key: key);

  String tabType;
  SelectionConditionModel model;

  @override
  NewSearchPageState createState() => NewSearchPageState();
}

class NewSearchPageState extends State<NewSearchPage> {
  ConditionSearchModel conditionSearchModel;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TimeConditionModel>(
      initData: (model) {
        conditionSearchModel = model;
        loadData(model);
      },
      model: TimeConditionModel(widget.tabType)
        ..selectionConditionModel = widget.model,
      builder: (_, TimeConditionModel model, __) {
        debugPrint("build_new_search_page");
        if (!model.isSuccess()) {
          return CommonViewStateHelper(
            model: model,
            onEmptyPressed: () => loadData(model),
            onErrorPressed: () => loadData(model),
            onNoNetworkPressed: () => loadData(model),
          );
        }

        Provider.of<SelectionConditionModel>(context).qty = model.qty.toString();
        return FooterLoadMoreWidget(
          topBouncing: false,
          bottomBouncing: false,
          easyRefreshController: model.easyRefreshController,
          onLoadMore: (model.qty ?? 0) <= 36
              ? null
              : () async {
                  await model.loadMoreConditionSearchData();
                  setState(() {});
                },
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 67,
              ),
              CommonGrid(
                model.conditionSearchBeanDatas,
                isShowTag: false,
              ),
            ],
          ),
        );
      },
    );
  }

  void loadData(TimeConditionModel model) {
    model.getConditionSearchApiData();
  }

  void refreshData() {
    conditionSearchModel.refreshConditionSearchApiData();
  }

  bool isLoading() {
    return conditionSearchModel.isLoading();
  }
}
