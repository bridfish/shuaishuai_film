import 'package:shuaishuaimovie/generated/json/base/json_convert_content.dart';
import 'package:shuaishuaimovie/generated/json/base/json_filed.dart';

class SelectConditionBeanEntity with JsonConvert<SelectConditionBeanEntity> {
	SelectConditionCommonBean areas;
	SelectConditionCommonBean classes;
	List<SelectConditionInnerBean> languages;
	int status;
	SelectConditionCommonBean types;
}

class SelectConditionCommonBean with JsonConvert<SelectConditionCommonBean> {
	@JSONField(name: "动漫")
	List<SelectConditionInnerBean> cartoon;
	@JSONField(name: "电影")
	List<SelectConditionInnerBean> movie;
	@JSONField(name: "综艺")
	List<SelectConditionInnerBean> show;
	@JSONField(name: "连续剧")
	List<SelectConditionInnerBean> teleplay;
}

class SelectConditionInnerBean with JsonConvert<SelectConditionInnerBean> {
	String name;
	int id;
}


