import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/common_tab_item_bean_entity.dart';

commonTabItemBeanEntityFromJson(CommonTabItemBeanEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<CommonTabItemBeanData>();
		(json['data'] as List).forEach((v) {
			data.data.add(new CommonTabItemBeanData().fromJson(v));
		});
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	return data;
}

Map<String, dynamic> commonTabItemBeanEntityToJson(CommonTabItemBeanEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}
	data['status'] = entity.status;
	return data;
}

commonTabItemBeanDataFromJson(CommonTabItemBeanData data, Map<String, dynamic> json) {
	if (json['ID'] != null) {
		data.iD = json['ID']?.toInt();
	}
	if (json['Name'] != null) {
		data.name = json['Name']?.toString();
	}
	if (json['Items'] != null) {
		data.items = new List<CommonItemBean>();
		(json['Items'] as List).forEach((v) {
			data.items.add(new CommonItemBean().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> commonTabItemBeanDataToJson(CommonTabItemBeanData entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['ID'] = entity.iD;
	data['Name'] = entity.name;
	if (entity.items != null) {
		data['Items'] =  entity.items.map((v) => v.toJson()).toList();
	}
	return data;
}
