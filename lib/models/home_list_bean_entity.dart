import 'package:shuaishuaimovie/generated/json/base/json_convert_content.dart';

import 'common_item_bean_entity.dart';

class HomeListBeanEntity with JsonConvert<HomeListBeanEntity> {
	List<CommonItemBean> c;
	List<CommonItemBean> h;
	List<CommonItemBean> m;
	List<CommonItemBean> s;
	List<CommonItemBean> t;
	int lastQty;
	String notice;
	int status;
}



