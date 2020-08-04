import 'package:shuaishuaimovie/generated/json/base/json_convert_content.dart';
import 'package:shuaishuaimovie/generated/json/base/json_filed.dart';

class CommonItemBean with JsonConvert<CommonItemBean> {
  @JSONField(name: "VodID")
  int vodID;
  @JSONField(name: "VodName")
  String vodName;
  @JSONField(name: "VodPic")
  String vodPic;
  @JSONField(name: "VodYear")
  String vodYear;
  @JSONField(name: "VodArea")
  String vodArea;
  @JSONField(name: "VodRemarks")
  String vodRemarks;
  @JSONField(name: "VodHits")
  int vodHits;
  @JSONField(name: "VodActor")
  String vodActor;
  @JSONField(name: "VodDirector")
  String vodDirector;
  @JSONField(name: "VodTime")
  int vodTime;
  @JSONField(name: "VodTypeID")
  int vodTypeID;
  @JSONField(name: "VodClass")
  CommonItemBeanVodClass vodClass;
}


class CommonItemBeanVodClass with JsonConvert<CommonItemBeanVodClass> {
  @JSONField(name: "TypeID")
  int typeID;
  @JSONField(name: "TypeName")
  String typeName;
}