import 'package:shuaishuaimovie/generated/json/base/json_convert_content.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';

class TxtAutoSearchBeanEntity with JsonConvert<TxtAutoSearchBeanEntity> {
  List<CommonItemBean> data;
  int status;
}


