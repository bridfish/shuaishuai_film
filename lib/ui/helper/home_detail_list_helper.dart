import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/ui/helper/common_list_helper.dart';


class DetailListTile extends StatelessWidget {
  const DetailListTile(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
        height: 40,
        child: Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        )
    );
  }
}

class NarrowList extends StatelessWidget {
  NarrowList(this.list);

  List<CommonItemBean> list;


  int itemCount() {
    return list.length;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("NarrowList");
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          CommonItemBean commonItemBean = list[index];
          return GestureDetector(
            onTap: () {
              print(commonItemBean.vodID);
              jumpHomeDetail(
                  context, commonItemBean.vodID.toString(), commonItemBean.vodPic,
                  replace: true);
            },
            child: SizedBox(
              height: 120,
              width: 130,
              child: CommonNarrowListItem(commonItemBean),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: 5,
          );
        },
        itemCount: itemCount(),
      ),
    );
  }
}

class CommonNarrowListItem extends StatelessWidget {
  CommonNarrowListItem(this.commonItemBean);

  final CommonItemBean commonItemBean;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _buildNarrowItemImgModule(),
        ),
        buildItemTxtModule(commonItemBean.vodName, commonItemBean.vodActor),
      ],
    );
  }

  _buildNarrowItemImgModule() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          buildItemImg(commonItemBean.vodPic),
          buildUpdateInfoTxt(commonItemBean.vodRemarks),
        ],
      ),
    );
  }
}




