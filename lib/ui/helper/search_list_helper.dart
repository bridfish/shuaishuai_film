import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/select_condition_bean_entity.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/ui/pages/search/condition_search_page.dart';
import 'package:shuaishuaimovie/viewmodels/search/select_condition_model.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class ConditionSearchList extends StatefulWidget {
  ConditionSearchList(this.list, this.type, {this.onSelected});

  List<SelectConditionInnerBean> list;
  String type;
  ValueChanged<int> onSelected;

  @override
  _ConditionSearchListState createState() => _ConditionSearchListState();
}

class _ConditionSearchListState extends State<ConditionSearchList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SelectionConditionModel>(
      builder: (_, model, __) {
        return Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.symmetric(
                vertical: BorderSide(color: AppColor.lightGrey, width: .2)),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              switch (widget.type) {
                case ConditionSearchPage.AREA_TYPE:
                  return GestureDetector(
                      onTap: () {
                        widget.onSelected(index);
                      },
                      child: _childWidget(index, model.selectedAreaIndex));
                case ConditionSearchPage.LETTER_TYPE:
                  return GestureDetector(
                      onTap: () {
                        widget.onSelected(index);
                      },
                      child: _childWidget(index, model.selectedLetterIndex));
                case ConditionSearchPage.LANG_TYPE:
                  return GestureDetector(
                      onTap: () {
                        widget.onSelected(index);
                      },
                      child: _childWidget(index, model.selectedLangIndex));
                case ConditionSearchPage.CLASS_TYPE:
                  return GestureDetector(
                      onTap: () {
                        widget.onSelected(index);
                      },
                      child: _childWidget(index, model.selectedClassIndex));
                case ConditionSearchPage.YEAR_TYPE:
                  return GestureDetector(
                      onTap: () {
                        widget.onSelected(index);
                      },
                      child: _childWidget(index, model.selectedYearIndex));
              }
              return SizedBox.shrink();
            },
            itemCount: widget.list.length,
          ),
        );
      },
    );
  }

  Widget _childWidget(int index, int currentIndex) {
    Widget child = index != currentIndex
        ? Container(
            constraints: BoxConstraints(minWidth: 20),
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            alignment: Alignment.center,
            child: CommonText(
              widget.list[index].name,
              txtColor: AppColor.default_txt_grey,
            ),
          )
        : selectedWidget(widget.list[index].name);

    return Container(
      height: 40,
      alignment: Alignment.center,
      color: AppColor.white,
      padding: EdgeInsets.only(left: index == 0 ? 10 : 5, right: 5),
      child: child,
    );
  }
}

class SelectedListWidget extends StatelessWidget {
  SelectedListWidget(this.list);

  List<String> list;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.symmetric(
            vertical: BorderSide(color: AppColor.lightGrey, width: .2)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            height: 40,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: selectedWidget(list[index]),
          );
        },
        itemCount: list.length,
      ),
    );
  }
}

Widget selectedWidget(String txt) {
  return Container(
    constraints: BoxConstraints(
      minWidth: 20,
    ),
    height: 25,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: AppColor.line_grey,
    ),
    child: CommonText(
      txt,
      txtColor: AppColor.icon_yellow,
    ),
  );
}

class NormalSearchList extends StatelessWidget {
  NormalSearchList(this.list, {this.jumpCallback});

  VoidCallback jumpCallback;

  List<CommonItemBean> list;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          CommonItemBean bean = list[index];
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 150,
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2),
                      child: Stack(
                        children: <Widget>[
                          CachedNetworkImage(
                            imageUrl: bean.vodPic,
                            fit: BoxFit.cover,
                            width: 110,
                            height: 150,
                            placeholder: (context, url) {
                              return Center(
                                child: CupertinoActivityIndicator(),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return Center(
                                child: Icon(
                                  Icons.error,
                                  size: 30,
                                  color: AppColor.icon_yellow,
                                ),
                              );
                            },
                          ),
                          Positioned(
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: double.infinity,
                              height: 20,
                              alignment: Alignment.topRight,
                              padding: EdgeInsets.only(right: 5, left: 5),
                              color: Colors.black.withOpacity(.5),
                              child: CommonText(
                                bean.vodRemarks,
                                txtColor: AppColor.white,
                                maxLine: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          CommonText(
                            bean.vodName,
                            maxLine: 1,
                            txtSize: 17,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CommonText(
                            "主演： ${bean.vodActor}",
                            maxLine: 1,
                            txtSize: 13,
                            txtColor: AppColor.default_txt_grey,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CommonText(
                            "导演： ${bean.vodDirector}",
                            maxLine: 1,
                            txtSize: 13,
                            txtColor: AppColor.default_txt_grey,
                          ),
                          Spacer(),
                          GestureDetector(
                            onTap: () {
                              jumpCallback();
                              jumpHomeDetail(
                                  context, bean.vodID.toString(), bean.vodPic);
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: CommonText(
                                "查看详情 》",
                                txtSize: 14,
                                txtColor: AppColor.icon_yellow,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              //分割线
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                height: 1,
                color: AppColor.line_grey,
              ),
            ],
          );
        },
        childCount: list?.length ?? 0,
      ),
    );
  }
}
