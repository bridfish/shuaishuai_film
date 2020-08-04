import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/hot_update_bean_entity.dart';

hotUpdateBeanEntityFromJson(HotUpdateBeanEntity data, Map<String, dynamic> json) {
	if (json['data'] != null) {
		data.data = new List<CommonItemBean>();
		(json['data'] as List).forEach((v) {
			data.data.add(new CommonItemBean().fromJson(v));
		});
	}

	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}

	return data;
}

Map<String, dynamic> hotUpdateBeanEntityToJson(HotUpdateBeanEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.data != null) {
		data['data'] =  entity.data.map((v) => v.toJson()).toList();
	}

	data['status'] = entity.status;

	return data;
}