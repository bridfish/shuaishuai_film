import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/hot_rank_bean_entity.dart';

hotRankBeanEntityFromJson(HotRankBeanEntity data, Map<String, dynamic> json) {
	if (json['cartoon'] != null) {
		data.cartoon = new List<CommonItemBean>();
		(json['cartoon'] as List).forEach((v) {
			data.cartoon.add(new CommonItemBean().fromJson(v));
		});
	}

	if (json['movie'] != null) {
		data.movie = new List<CommonItemBean>();
		(json['movie'] as List).forEach((v) {
			data.movie.add(new CommonItemBean().fromJson(v));
		});
	}

	if (json['show'] != null) {
		data.show = new List<CommonItemBean>();
		(json['show'] as List).forEach((v) {
			data.show.add(new CommonItemBean().fromJson(v));
		});
	}

	if (json['teleplay'] != null) {
		data.teleplay = new List<CommonItemBean>();
		(json['teleplay'] as List).forEach((v) {
			data.teleplay.add(new CommonItemBean().fromJson(v));
		});
	}

	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	return data;
}

Map<String, dynamic> hotRankBeanEntityToJson(HotRankBeanEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.cartoon != null) {
		data['cartoon'] =  entity.cartoon.map((v) => v.toJson()).toList();
	}

	if (entity.movie != null) {
		data['movie'] =  entity.movie.map((v) => v.toJson()).toList();
	}

	if (entity.show != null) {
		data['show'] =  entity.show.map((v) => v.toJson()).toList();
	}

	if (entity.teleplay != null) {
		data['teleplay'] =  entity.teleplay.map((v) => v.toJson()).toList();
	}
	data['status'] = entity.status;
	return data;
}
