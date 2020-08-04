import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/home_list_bean_entity.dart';

homeListBeanEntityFromJson(HomeListBeanEntity data, Map<String, dynamic> json) {
	if (json['c'] != null) {
		data.c = new List<CommonItemBean>();
		(json['c'] as List).forEach((v) {
			data.c.add(new CommonItemBean().fromJson(v));
		});
	}
	if (json['h'] != null) {
		data.h = new List<CommonItemBean>();
		(json['h'] as List).forEach((v) {
			data.h.add(new CommonItemBean().fromJson(v));
		});
	}
	if (json['m'] != null) {
		data.m = new List<CommonItemBean>();
		(json['m'] as List).forEach((v) {
			data.m.add(new CommonItemBean().fromJson(v));
		});
	}
	if (json['s'] != null) {
		data.s = new List<CommonItemBean>();
		(json['s'] as List).forEach((v) {
			data.s.add(new CommonItemBean().fromJson(v));
		});
	}
	if (json['t'] != null) {
		data.t = new List<CommonItemBean>();
		(json['t'] as List).forEach((v) {
			data.t.add(new CommonItemBean().fromJson(v));
		});
	}
	if (json['lastQty'] != null) {
		data.lastQty = json['lastQty']?.toInt();
	}
	if (json['notice'] != null) {
		data.notice = json['notice']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	return data;
}

Map<String, dynamic> homeListBeanEntityToJson(HomeListBeanEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.c != null) {
		data['c'] =  entity.c.map((v) => v.toJson()).toList();
	}
	if (entity.h != null) {
		data['h'] =  entity.h.map((v) => v.toJson()).toList();
	}
	if (entity.m != null) {
		data['m'] =  entity.m.map((v) => v.toJson()).toList();
	}
	if (entity.s != null) {
		data['s'] =  entity.s.map((v) => v.toJson()).toList();
	}
	if (entity.t != null) {
		data['t'] =  entity.t.map((v) => v.toJson()).toList();
	}
	data['lastQty'] = entity.lastQty;
	data['notice'] = entity.notice;
	data['status'] = entity.status;
	return data;
}