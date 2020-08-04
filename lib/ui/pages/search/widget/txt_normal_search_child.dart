import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/ui/helper/search_list_helper.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/viewmodels/search/txt_normal_search_model.dart';
import 'package:shuaishuaimovie/widgets/custom_refresh_widget.dart';

class TxtNormalSearchChild extends StatefulWidget {
  TxtNormalSearchChild({this.jumpCallback, Key key}) : super(key: key);
  VoidCallback jumpCallback;

  @override
  TxtNormalSearchChildState createState() => TxtNormalSearchChildState();
}

class TxtNormalSearchChildState extends State<TxtNormalSearchChild> {
  String keyword;
  NormalSearchModel model;

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<NormalSearchModel>(
      initData: (model) {
        this.model = model;
      },
      model: NormalSearchModel(),
      builder: (_, NormalSearchModel model, child) {
        print(model.isSuccess());
        if (!model.isSuccess() &&
            (keyword == null ? false : keyword.isNotEmpty)) {
          return CommonViewStateHelper(
            model: model,
            onEmptyPressed: () => loadData(keyword),
            onErrorPressed: () => loadData(keyword),
            onNoNetworkPressed: () => loadData(keyword),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: CustomFooterLoadMoreWidget(
            easyRefreshController: model.easyRefreshController,
            onLoadMore: (model.qty ?? 0) <= 36
                ? null
                : () async {
                    await model.loadMoreNormalSearchData();
                  },
            slivers: <Widget>[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text.rich(TextSpan(
                    text: "搜索到与",
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 17,
                    ),
                    children: [
                      TextSpan(
                        text: "\"$keyword\"",
                        style: TextStyle(
                          color: AppColor.icon_yellow,
                        ),
                      ),
                      TextSpan(
                        text: "相关的",
                        style: TextStyle(
                          color: AppColor.black,
                        ),
                      ),
                      TextSpan(
                        text: model.qty.toString(),
                        style: TextStyle(
                          color: AppColor.icon_yellow,
                        ),
                      ),
                      TextSpan(
                        text: "条结果",
                        style: TextStyle(
                          color: AppColor.black,
                        ),
                      ),
                    ],
                  )),
                ),
              ),
              NormalSearchList(
                model.conditionSearchBeanDatas,
                jumpCallback: widget.jumpCallback,
              ),
            ],
          ),
        );
      },
    );
  }

  void loadData(String keyword) {
    this.keyword = keyword;
    model.getNormalSearchApiData(keyword);
  }

  void resetData() {
    model.currentPage = 1;
  }
}
