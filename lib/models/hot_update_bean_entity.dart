import 'package:shuaishuaimovie/generated/json/base/json_convert_content.dart';

import 'common_item_bean_entity.dart';

class HotUpdateBeanEntity with JsonConvert<HotUpdateBeanEntity> {
  List<CommonItemBean> data;
  int status;

}
