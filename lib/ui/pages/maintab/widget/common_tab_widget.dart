import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/models/common_tab_item_bean_entity.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/ui/helper/common_list_helper.dart';
import 'package:shuaishuaimovie/viewmodels/tab/commontab/common_tab_model.dart';
import 'package:shuaishuaimovie/widgets/custom_refresh_widget.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class CommonTabWidget extends StatelessWidget {
  CommonTabWidget(this.model, this.name);

  CommonTabModel model;
  String name;

  @override
  Widget build(BuildContext context) {
    return _buildContent(model);
  }

  Widget _buildContent(CommonTabModel model) {
    return CustomHeaderRefreshWidget(
      onRefresh: model.refreshCommonTabData,
      easyRefreshController: model.easyRefreshController,
      slivers: <Widget>[
        SliverToBoxAdapter(
          child:
              CommonTabHeaderWidget(model.commonTabItemBeanEntity.data, name),
        ),
        ...List.generate(model.commonTabItemBeanEntity.data.length, (index) {
          return CommonTabItemWidget(
              model.commonTabItemBeanEntity.data[index], name);
        }).toList(),
      ],
    );
  }

  loadData(CommonTabModel model) {
    model.getCommonTabApiData();
  }
}

class CommonTabHeaderWidget extends StatelessWidget {
  CommonTabHeaderWidget(this.list, this.name);

  List<CommonTabItemBeanData> list;
  String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.black,
      height: 50,
      child: Stack(
        children: <Widget>[
          ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2,
              ),
              child: DropDownWidget(list, name)),
          Container(
            height: 50,
            margin: EdgeInsets.only(right: 35),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  List.generate(list.length > 5 ? 5 : list.length + 1, (index) {

                return index == 1 ? SizedBox.shrink() : Expanded(
                  flex: index == 0 ? 4 : 3,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: AppColor.black,
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        jumpConditionSearch(context, name, classes: index == 0 ? "" : list[index - 1].name);
                      },
                      child: _headerItem(list, index, name),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class CommonTabItemWidget extends StatelessWidget {
  CommonTabItemWidget(this.data, this.name);

  CommonTabItemBeanData data;
  String name;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: <Widget>[
          CommonListTile(
            data.name,
            backMoreValue: data.name,
            onMorePressed: (value) {
              jumpConditionSearch(context, name, classes: data.name);
            },
          ),
          CommonGrid(
            data.items,
            isShowTag: false,
          ),
        ],
      ),
    );
  }
}

class DropDownWidget extends StatelessWidget {
  DropDownWidget(this.list, this.name);

  String name;
  List<CommonTabItemBeanData> list;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(1.1, -1),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColor.black,
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            iconEnabledColor: AppColor.white,
            items: List.generate(list.length + 1, (index) {
              return DropdownMenuItem(
                  child: GestureDetector(
                      onTap: () {
                        //关闭dropdown widget
                        Navigator.of(context).pop();

                        jumpConditionSearch(context, name, classes: index == 0 ? "" : list[index - 1].name);
                      },
                      child: Container(
                        color: AppColor.black,
                          child: _headerItem(list, index, name))));
            }),
            onChanged: (value) {},
            isExpanded: true,
            elevation: 0,
            icon: Container(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _headerItem(List<CommonTabItemBeanData> list, int index, String title) {
  return index == 0
      ? Row(
          children: <Widget>[
            Icon(Icons.list),
            CommonText(
              title + "片库",
              txtColor: AppColor.white,
            ),
          ],
        )
      : CommonText(
          list[index - 1].name,
          txtColor: AppColor.white,
        );
}
