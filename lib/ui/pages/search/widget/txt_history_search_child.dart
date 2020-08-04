import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/viewmodels/search/txt_history_search_model.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class TxtHistorySearchChild extends StatefulWidget {
  TxtHistorySearchChild({this.onHistoryTxtTap});

  ValueChanged onHistoryTxtTap;

  @override
  _TxtHistorySearchChildState createState() => _TxtHistorySearchChildState();
}

class _TxtHistorySearchChildState extends State<TxtHistorySearchChild> {
  TxtHistorySearchModel model;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TxtHistorySearchModel>(
      initData: (model) {
        this.model = model;
        model.getLocalHistorySearchData();
      },
      model: TxtHistorySearchModel(),
      builder:
          (BuildContext context, TxtHistorySearchModel model, Widget child) {
        return model.historySearchList != null && model.historySearchList.length > 0
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                alignment: Alignment.topCenter,
                child: CustomScrollView(
                  slivers: <Widget>[
                    SliverPadding(
                      padding: EdgeInsets.only(top: 30),
                      sliver: SliverToBoxAdapter(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CommonText(
                              "历史记录",
                              txtColor: AppColor.default_txt_grey,
                              txtSize: 15,
                            ),
                            _buildOperateDel(model),
                          ],
                        ),
                      ),
                    ),
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 4,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              widget.onHistoryTxtTap(
                                  model.historySearchList[index][model.columnName]);
                            },
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                    height: 25,
                                    padding: EdgeInsets.only(
                                        left: index % 2 == 0 ? 0 : 10),
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      children: <Widget>[
                                        CommonText(
                                          model.historySearchList[index]
                                              [model.columnName],
                                          txtSize: 14,
                                        ),
                                        Spacer(),
                                        if (model.isShowCloseIcon)
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            onTap: () {
                                              model.delSearchHistoryData(index);
                                            },
                                            child: Padding(
                                              padding: EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.clear,
                                                size: 17,
                                              ),
                                            ),
                                          ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                if (index % 2 == 0)
                                  Container(
                                    width: 1,
                                    height: 15,
                                    color: Colors.grey[350],
                                  ),
                              ],
                            ),
                          );
                        },
                        childCount: model.historySearchList?.length ?? 0,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                padding: EdgeInsets.only(top: 100),
                alignment: Alignment.topCenter,
                child: Text("快点试试搜索一下哦"),
              );
      },
    );
  }

  Widget _buildOperateDel(TxtHistorySearchModel model) {
    return model.isShowCloseIcon
        ? Row(
            children: <Widget>[
              GestureDetector(
                  onTap: () {
                    model.delSearchHistoryAllDatas();
                  },
                  child: CommonText("全部删除")),
              SizedBox(
                width: 15,
              ),
              GestureDetector(
                  onTap: () {
                    model.changeShowCloseStatus();
                  },
                  child: CommonText("完成")),
            ],
          )
        : GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              model.changeShowCloseStatus();
            },
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Icon(Icons.delete_outline),
            ),
          );
  }

  @override
  void didUpdateWidget(TxtHistorySearchChild oldWidget) {
    super.didUpdateWidget(oldWidget);
    model.getLocalHistorySearchData();
  }
}
