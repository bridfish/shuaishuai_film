import 'package:shuaishuaimovie/generated/json/base/json_convert_content.dart';
import 'package:shuaishuaimovie/generated/json/base/json_filed.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';

class CommonTabItemBeanEntity with JsonConvert<CommonTabItemBeanEntity> {
	List<CommonTabItemBeanData> data;
	int status;
}

class CommonTabItemBeanData with JsonConvert<CommonTabItemBeanData> {
	@JSONField(name: "ID")
	int iD;
	@JSONField(name: "Name")
	String name;
	@JSONField(name: "Items")
	List<CommonItemBean> items;
}

