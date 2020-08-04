import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/viewmodels/search/txt_auto_search_model.dart';

class TxtAutoSearchChild extends StatefulWidget {
  TxtAutoSearchChild({Key key, this.jumpCallback}) : super(key: key);
  VoidCallback jumpCallback;

  @override
  TxtAutoSearchChildState createState() => TxtAutoSearchChildState();
}

class TxtAutoSearchChildState extends State<TxtAutoSearchChild> {
  TxtAutoSearchModel model;
  String keyword = "";

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<TxtAutoSearchModel>(
      initData: (model) {
        this.model = model;
      },
      model: TxtAutoSearchModel(),
      builder: (_, TxtAutoSearchModel model, child) {
        return Container(
          color: AppColor.white,
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              CommonItemBean bean = model.txtAutoSearchBeanDatas[index];
              return ListTile(
                onTap: () {
                  widget.jumpCallback();
                  jumpHomeDetail(context, bean.vodID.toString(), bean.vodPic);
                },
                title: Text.rich(
                  TextSpan(children: [
                    for (String txt
                    in model.processedTxt(bean.vodName, keyword))
                      TextSpan(
                        text: txt,
                        style: TextStyle(
                          color: txt == keyword
                              ? AppColor.icon_yellow
                              : AppColor.black,
                        ),
                      ),
                  ]),
                ),
              );
            },
            itemCount: model.txtAutoSearchBeanDatas?.length ?? 0,
            separatorBuilder: (BuildContext context, int index) {
              return Container(
                height: 1,
                color: AppColor.line_grey,
              );
            },
          ),
        );
      },
    );
  }


  Future loadData(String keyword) async{
    this.keyword = keyword;
    await model.getTxtAutoSearchApiData(keyword);
  }

  void resetData() {
    model.clearData();
  }
}
