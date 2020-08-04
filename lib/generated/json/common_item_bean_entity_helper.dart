import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';

commonItemBeanFromJson(CommonItemBean data, Map<String, dynamic> json) {
	if (json['VodID'] != null) {
		data.vodID = json['VodID']?.toInt();
	}
	if (json['VodName'] != null) {
		data.vodName = json['VodName']?.toString();
	}
	if (json['VodPic'] != null) {
		data.vodPic = json['VodPic']?.toString();
	}
	if (json['VodYear'] != null) {
		data.vodYear = json['VodYear']?.toString();
	}
	if (json['VodArea'] != null) {
		data.vodArea = json['VodArea']?.toString();
	}
	if (json['VodRemarks'] != null) {
		data.vodRemarks = json['VodRemarks']?.toString();
	}
	if (json['VodHits'] != null) {
		data.vodHits = json['VodHits']?.toInt();
	}
	if (json['VodActor'] != null) {
		data.vodActor = json['VodActor']?.toString();
	}
	if (json['VodDirector'] != null) {
		data.vodDirector = json['VodDirector']?.toString();
	}
	if (json['VodTime'] != null) {
		data.vodTime = json['VodTime']?.toInt();
	}
	if (json['VodTypeID'] != null) {
		data.vodTypeID = json['VodTypeID']?.toInt();
	}
	if (json['VodClass'] != null) {
		data.vodClass = new CommonItemBeanVodClass().fromJson(json['VodClass']);
	}
	return data;
}

Map<String, dynamic> commonItemBeanToJson(CommonItemBean entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['VodID'] = entity.vodID;
	data['VodName'] = entity.vodName;
	data['VodPic'] = entity.vodPic;
	data['VodYear'] = entity.vodYear;
	data['VodArea'] = entity.vodArea;
	data['VodRemarks'] = entity.vodRemarks;
	data['VodHits'] = entity.vodHits;
	data['VodActor'] = entity.vodActor;
	data['VodDirector'] = entity.vodDirector;
	data['VodTime'] = entity.vodTime;
	data['VodTypeID'] = entity.vodTypeID;
	if (entity.vodClass != null) {
		data['VodClass'] = entity.vodClass.toJson();
	}
	return data;
}

commonItemBeanVodClassFromJson(CommonItemBeanVodClass data, Map<String, dynamic> json) {
	if (json['TypeID'] != null) {
		data.typeID = json['TypeID']?.toInt();
	}
	if (json['TypeName'] != null) {
		data.typeName = json['TypeName']?.toString();
	}
	return data;
}

Map<String, dynamic> commonItemBeanVodClassToJson(CommonItemBeanVodClass entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['TypeID'] = entity.typeID;
	data['TypeName'] = entity.typeName;
	return data;
}