import 'package:shuaishuaimovie/models/select_condition_bean_entity.dart';

selectConditionBeanEntityFromJson(SelectConditionBeanEntity data, Map<String, dynamic> json) {
	if (json['areas'] != null) {
		data.areas = new SelectConditionCommonBean().fromJson(json['areas']);
	}
	if (json['classes'] != null) {
		data.classes = new SelectConditionCommonBean().fromJson(json['classes']);
	}
	if (json['languages'] != null) {
		data.languages = new List<SelectConditionInnerBean>();
		(json['languages'] as List).forEach((v) {
			data.languages.add(new SelectConditionInnerBean().fromJson(v));
		});
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['types'] != null) {
		data.types = new SelectConditionCommonBean().fromJson(json['types']);
	}
	return data;
}

Map<String, dynamic> selectConditionBeanEntityToJson(SelectConditionBeanEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.areas != null) {
		data['areas'] = entity.areas.toJson();
	}
	if (entity.classes != null) {
		data['classes'] = entity.classes.toJson();
	}
	if (entity.languages != null) {
		data['languages'] =  entity.languages.map((v) => v.toJson()).toList();
	}
	data['status'] = entity.status;
	if (entity.types != null) {
		data['types'] = entity.types.toJson();
	}
	return data;
}

selectConditionCommonBeanFromJson(SelectConditionCommonBean data, Map<String, dynamic> json) {
	if (json['电影'] != null) {
		data.movie = new List<SelectConditionInnerBean>();
		(json['电影'] as List).forEach((v) {
			data.movie.add(new SelectConditionInnerBean().fromJson(v));
		});
	}

	if (json['动漫'] != null) {
		data.cartoon = new List<SelectConditionInnerBean>();
		(json['动漫'] as List).forEach((v) {
			data.cartoon.add(new SelectConditionInnerBean().fromJson(v));
		});
	}

	if (json['综艺'] != null) {
		data.show = new List<SelectConditionInnerBean>();
		(json['综艺'] as List).forEach((v) {
			data.show.add(new SelectConditionInnerBean().fromJson(v));
		});
	}

	if (json['连续剧'] != null) {
		data.teleplay = new List<SelectConditionInnerBean>();
		(json['连续剧'] as List).forEach((v) {
			data.teleplay.add(new SelectConditionInnerBean().fromJson(v));
		});
	}
	return data;
}

Map<String, dynamic> selectConditionCommonBeanToJson(SelectConditionCommonBean entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.movie != null) {
		data['电影'] =  entity.movie.map((v) => v.toJson()).toList();
	}

	if (entity.cartoon != null) {
		data['动漫'] =  entity.cartoon.map((v) => v.toJson()).toList();
	}

	if (entity.show != null) {
		data['综艺'] =  entity.show.map((v) => v.toJson()).toList();
	}

	if (entity.teleplay != null) {
		data['连续剧'] =  entity.teleplay.map((v) => v.toJson()).toList();
	}

	return data;
}

selectConditionInnerBeanFromJson(SelectConditionInnerBean data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name'];
	}

	if (json['id'] != null) {
		data.id = json['id'];
	}
	return data;
}

Map<String, dynamic> selectConditionInnerBeanToJson(SelectConditionInnerBean entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['id'] = entity.id;
	return data;
}

