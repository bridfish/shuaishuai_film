import 'package:shuaishuaimovie/generated/json/base/json_convert_content.dart';

import 'common_item_bean_entity.dart';

class ConditionSearchBeanEntity with JsonConvert<ConditionSearchBeanEntity> {
  List<CommonItemBean> data;
  int status;
  int qty;

}