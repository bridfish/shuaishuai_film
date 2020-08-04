import 'package:shuaishuaimovie/generated/json/base/json_convert_content.dart';
import 'package:shuaishuaimovie/generated/json/base/json_filed.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';

class HotRankBeanEntity with JsonConvert<HotRankBeanEntity> {
	List<CommonItemBean> cartoon;
	List<CommonItemBean> movie;
	List<CommonItemBean> show;
	List<CommonItemBean> teleplay;
	int status;
}

