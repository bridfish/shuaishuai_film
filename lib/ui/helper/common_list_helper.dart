import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/routes/route_jump.dart';
import 'package:shuaishuaimovie/widgets/tag_widget.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class CommonGrid extends StatelessWidget {
  CommonGrid(this.list, {this.isShowTag = true});

  List<CommonItemBean> list;
  bool isShowTag;

  int itemCount() {
    return list.length;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 2,
        crossAxisSpacing: 5,
        childAspectRatio: 200 / 360,
      ),
      itemBuilder: (context, index) {
        CommonItemBean commonItemBean = list[index];
        return GestureDetector(
          onTap: () {
            jumpHomeDetail(context, commonItemBean.vodID.toString(),
                commonItemBean.vodPic);
          },
          child: CommonListItem(commonItemBean, isShowTag),
        );
      },
      itemCount: itemCount(),
    );
  }
}

class CommonListItem extends StatelessWidget {
  CommonListItem(this.commonItemBean, this.isShowTag);

  bool isShowTag;

  final CommonItemBean commonItemBean;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildItemImgModule(isShowTag),
          buildItemTxtModule(commonItemBean.vodName, commonItemBean.vodActor),
        ],
      ),
    );
  }

  _buildItemImgModule(isShowTag) {
    return AspectRatio(
      aspectRatio: 257 / 360,
      child: Stack(
        children: <Widget>[
          buildItemImg(commonItemBean.vodPic),
          Positioned(
            left: 5,
            top: 5,
            child: Row(
              children: <Widget>[
                if (isShowTag)
                  buildItemTag(commonItemBean.vodYear, AppColor.blue),
                if (commonItemBean.vodYear != null)
                  SizedBox(
                    width: 5,
                  ),
                if (isShowTag)
                  buildItemTag(
                      commonItemBean.vodClass.typeName, AppColor.icon_yellow),
              ],
            ),
          ),
          if (isShowTag) buildUpdateInfoTxt(commonItemBean.vodRemarks),
        ],
      ),
    );
  }
}

class CommonListTile extends StatelessWidget {
  const CommonListTile(this.title, {this.iconData, this.onMorePressed, this.backMoreValue});

  final IconData iconData;
  final String title;
  final dynamic backMoreValue;
  final ValueChanged onMorePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      height: 50,
      child: Row(
        children: <Widget>[
          buildListTileTitle(iconData, title),
          GestureDetector(
            onTap: (){
              onMorePressed(backMoreValue);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: <Widget>[
                  Text(
                    "更多",
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
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

buildListTileTitle(IconData iconData, String title) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      buildIcon(iconData),
      SizedBox(
        width: 2,
      ),
      Text(
        title,
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ],
  );
}

buildIcon(IconData iconData) {
  if (iconData != null) {
    return Row(
      children: <Widget>[
        Icon(
          iconData,
          color: AppColor.icon_yellow,
          size: 18,
        ),
      ],
    );
  }
  return Container();
}

buildItemTxtModule(String title, String subTitle) {
  return Container(
    padding: EdgeInsets.all(5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        SizedBox(
          width: 2,
        ),
        Text(
          subTitle,
          style: TextStyle(
            fontSize: 11,
            color: AppColor.default_txt_grey,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ],
    ),
  );
}

buildItemImg(String imageUrl) {
  return ConstrainedBox(
    constraints: BoxConstraints.expand(),
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
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
  );
}

buildUpdateInfoTxt(String info) {
  return Positioned(
    left: 0,
    right: 0,
    bottom: 0,
    child: Container(
      width: double.infinity,
      height: 20,
      alignment: Alignment.topRight,
      padding: EdgeInsets.only(right: 5),
      color: Colors.black.withOpacity(.5),
      child: CommonText(
        info,
        txtColor: AppColor.white,
      ),
    ),
  );
}

buildItemTag(String tag, Color color) {
  if (tag != null) {
    return movieCustomTag(tag, color: color, radius: 2);
  }
  return Container();
}
