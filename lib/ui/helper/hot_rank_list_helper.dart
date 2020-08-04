import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/widgets/tag_widget.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class HotRankHeaderTile extends StatelessWidget {
  HotRankHeaderTile(this.title, {@required this.onMorePress});

  String title;
  VoidCallback onMorePress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        border: Border.symmetric(
            vertical: BorderSide(width: 1, color: AppColor.line_grey)),
      ),
      child: Row(
        children: <Widget>[
          CommonText(
            title,
            txtWeight: FontWeight.bold,
            txtSize: 14,
          ),
          Spacer(),
          GestureDetector(
            onTap: onMorePress,
            child: Padding(
              padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
              child: Row(
                children: <Widget>[
                  CommonText(
                    "更多",
                    txtSize: 11,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.black,
                    size: 12,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HotRankContentTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CommonSliverHotRankList extends StatelessWidget {
  CommonSliverHotRankList(this.list);

  List<CommonItemBean> list;

  int itemCount() {
    return list.length;
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          CommonItemBean commonItemBean = list[index];
          if (index == 0) {
            return _buildRankTopItem(context, commonItemBean);
          } else {
            return _buildRankItem(context, commonItemBean, index);
          }
        },
        childCount: itemCount(),
      ),
    );
  }
}

Widget _buildRankTopItem(
    BuildContext context, CommonItemBean commonItemBean) {
  return GestureDetector(
    onTap: () {
      jumpHomeDetail(context, commonItemBean.vodID.toString(), commonItemBean.vodPic);
    },
    child: Container(
      color: AppColor.white,
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: SizedBox(
              height: 100,
              width: 280 / 360 * 100,
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    width: double.infinity,
                    height: double.infinity,
                    imageUrl: commonItemBean.vodPic,
                    fit: BoxFit.cover,
                    placeholder: (context, url) {
                      return Center(
                        child: CupertinoActivityIndicator(),
                      );
                    },
                    errorWidget: (context, url, error) {
                      return Icon(
                        Icons.error,
                        size: 30,
                        color: AppColor.icon_yellow,
                      );
                    },
                  ),
                  rankTag(txt: "1", color: AppColor.red),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SizedBox(
                          child: CommonText(
                            commonItemBean.vodName,
                            txtSize: 14,
                            maxLine: 1,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.find_replace,
                        size: 12,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CommonText(
                        (commonItemBean.vodHits / 10000.0).toStringAsFixed(2) +
                            "万",
                        txtColor: AppColor.default_txt_grey,
                        txtSize: 12,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      CommonText(
                        commonItemBean.vodYear,
                        txtColor: AppColor.default_txt_grey,
                        txtSize: 12,
                      ),
                      CommonText(
                        " / ",
                        txtColor: AppColor.default_txt_grey,
                        txtSize: 12,
                      ),
                      CommonText(
                        commonItemBean.vodArea,
                        txtColor: AppColor.default_txt_grey,
                        txtSize: 12,
                      ),
                      CommonText(
                        " / ",
                        txtColor: AppColor.default_txt_grey,
                        txtSize: 12,
                      ),
                      CommonText(
                        commonItemBean.vodClass.typeName,
                        txtColor: AppColor.default_txt_grey,
                        txtSize: 12,
                      ),
                    ],
                  ),
                  CommonText(
                    "状态: ${commonItemBean.vodRemarks}",
                    txtColor: AppColor.default_txt_grey,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildRankItem(
    BuildContext context, CommonItemBean commonItemBean, int index) {
  Color color = AppColor.default_txt_grey;
  switch (index) {
    case 1:
      color = Colors.orange;
      break;
    case 2:
      color = Colors.yellow[600];
      break;
    default:
      color = Colors.grey;
  }
  return GestureDetector(
    onTap: () {
      jumpHomeDetail(context, commonItemBean.vodID.toString(), commonItemBean.vodPic);
    },
    child: Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColor.white,
        border: Border(
          top: BorderSide(width: 1, color: AppColor.line_grey),
        ),
      ),
      child: Row(
        children: <Widget>[
          rankTag(txt: (index + 1).toString(), color: color),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: CommonText(
              commonItemBean.vodName,
              maxLine: 1,
              txtSize: 13,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Icon(
            Icons.find_replace,
            size: 12,
          ),
          SizedBox(
            width: 5,
          ),
          CommonText(
            (commonItemBean.vodHits / 10000.0).toStringAsFixed(2) + "万",
            txtColor: AppColor.default_txt_grey,
            txtSize: 12,
          ),
        ],
      ),
    ),
  );
}
