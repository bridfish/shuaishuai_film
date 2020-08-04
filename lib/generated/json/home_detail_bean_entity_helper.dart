import 'package:shuaishuaimovie/models/home_detail_bean_entity.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';

homeDetailBeanEntityFromJson(HomeDetailBeanEntity data, Map<String, dynamic> json) {
	if (json['count'] != null) {
		data.count = json['count']?.toInt();
	}
	if (json['domain'] != null) {
		data.domain = json['domain']?.toString();
	}
	if (json['rand'] != null) {
		data.rand = new List<CommonItemBean>();
		(json['rand'] as List).forEach((v) {
			data.rand.add(new CommonItemBean().fromJson(v));
		});
	}
	if (json['relate'] != null) {
		data.relate = new List<CommonItemBean>();
		(json['relate'] as List).forEach((v) {
			data.relate.add(new CommonItemBean().fromJson(v));
		});
	}
	if (json['shareLink'] != null) {
		data.shareLink = json['shareLink']?.toString();
	}
	if (json['status'] != null) {
		data.status = json['status']?.toInt();
	}
	if (json['vod'] != null) {
		data.vod = new HomeDetailBeanVod().fromJson(json['vod']);
	}
	return data;
}

Map<String, dynamic> homeDetailBeanEntityToJson(HomeDetailBeanEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['count'] = entity.count;
	data['domain'] = entity.domain;
	if (entity.rand != null) {
		data['rand'] =  entity.rand.map((v) => v.toJson()).toList();
	}
	if (entity.relate != null) {
		data['relate'] =  entity.relate.map((v) => v.toJson()).toList();
	}
	data['shareLink'] = entity.shareLink;
	data['status'] = entity.status;
	if (entity.vod != null) {
		data['vod'] = entity.vod.toJson();
	}
	return data;
}

homeDetailBeanVodFromJson(HomeDetailBeanVod data, Map<String, dynamic> json) {
	if (json['VodID'] != null) {
		data.vodID = json['VodID']?.toInt();
	}
	if (json['VodLevel'] != null) {
		data.vodLevel = json['VodLevel']?.toInt();
	}
	if (json['TypeID'] != null) {
		data.typeID = json['TypeID']?.toInt();
	}
	if (json['TypeID1'] != null) {
		data.typeID1 = json['TypeID1']?.toInt();
	}
	if (json['GroupID'] != null) {
		data.groupID = json['GroupID']?.toInt();
	}
	if (json['VodUp'] != null) {
		data.vodUp = json['VodUp']?.toInt();
	}
	if (json['VodName'] != null) {
		data.vodName = json['VodName']?.toString();
	}
	if (json['VodPic'] != null) {
		data.vodPic = json['VodPic']?.toString();
	}
	if (json['VodActor'] != null) {
		data.vodActor = json['VodActor']?.toString();
	}
	if (json['VodDirector'] != null) {
		data.vodDirector = json['VodDirector']?.toString();
	}
	if (json['VodBlurb'] != null) {
		data.vodBlurb = json['VodBlurb']?.toString();
	}
	if (json['VodContent'] != null) {
		data.vodContent = json['VodContent']?.toString();
	}
	if (json['VodYear'] != null) {
		data.vodYear = json['VodYear']?.toString();
	}
	if (json['VodScore'] != null) {
		data.vodScore = json['VodScore']?.toInt();
	}
	if (json['VodScoreAll'] != null) {
		data.vodScoreAll = json['VodScoreAll']?.toInt();
	}
	if (json['VodHits'] != null) {
		data.vodHits = json['VodHits']?.toInt();
	}
	if (json['VodScoreNum'] != null) {
		data.vodScoreNum = json['VodScoreNum']?.toInt();
	}
	if (json['VodArea'] != null) {
		data.vodArea = json['VodArea']?.toString();
	}
	if (json['VodRemarks'] != null) {
		data.vodRemarks = json['VodRemarks']?.toString();
	}
	if (json['Vps'] != null) {
		data.vps = json['Vps']?.toString();
	}
	if (json['Vpf'] != null) {
		data.vpf = json['Vpf']?.toString();
	}
	if (json['Vpl'] != null) {
		data.vpl = json['Vpl']?.toString();
	}
	if (json['VodHitsWeek'] != null) {
		data.vodHitsWeek = json['VodHitsWeek']?.toString();
	}
	if (json['VodTime'] != null) {
		data.vodTime = json['VodTime']?.toInt();
	}
	if (json['VodPlayServer'] != null) {
		data.vodPlayServer = new List<HomeDetailBeanVodVodPlayServer>();
		(json['VodPlayServer'] as List).forEach((v) {
			data.vodPlayServer.add(new HomeDetailBeanVodVodPlayServer().fromJson(v));
		});
	}
	if (json['VodPlayUrls'] != null) {
		data.vodPlayUrls = new HomeDetailBeanVodVodPlayUrls().fromJson(json['VodPlayUrls']);
	}
	if (json['VodClass'] != null) {
		data.vodClass = new HomeDetailBeanVodVodClass().fromJson(json['VodClass']);
	}
	return data;
}

Map<String, dynamic> homeDetailBeanVodToJson(HomeDetailBeanVod entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['VodID'] = entity.vodID;
	data['VodLevel'] = entity.vodLevel;
	data['TypeID'] = entity.typeID;
	data['TypeID1'] = entity.typeID1;
	data['GroupID'] = entity.groupID;
	data['VodUp'] = entity.vodUp;
	data['VodName'] = entity.vodName;
	data['VodPic'] = entity.vodPic;
	data['VodActor'] = entity.vodActor;
	data['VodDirector'] = entity.vodDirector;
	data['VodBlurb'] = entity.vodBlurb;
	data['VodContent'] = entity.vodContent;
	data['VodYear'] = entity.vodYear;
	data['VodScore'] = entity.vodScore;
	data['VodScoreAll'] = entity.vodScoreAll;
	data['VodHits'] = entity.vodHits;
	data['VodScoreNum'] = entity.vodScoreNum;
	data['VodArea'] = entity.vodArea;
	data['VodRemarks'] = entity.vodRemarks;
	data['Vps'] = entity.vps;
	data['Vpf'] = entity.vpf;
	data['Vpl'] = entity.vpl;
	data['VodHitsWeek'] = entity.vodHitsWeek;
	data['VodTime'] = entity.vodTime;
	if (entity.vodPlayServer != null) {
		data['VodPlayServer'] =  entity.vodPlayServer.map((v) => v.toJson()).toList();
	}
	if (entity.vodPlayUrls != null) {
		data['VodPlayUrls'] = entity.vodPlayUrls.toJson();
	}
	if (entity.vodClass != null) {
		data['VodClass'] = entity.vodClass.toJson();
	}
	return data;
}

homeDetailBeanVodVodPlayServerFromJson(HomeDetailBeanVodVodPlayServer data, Map<String, dynamic> json) {
	if (json['Status'] != null) {
		data.status = json['Status']?.toString();
	}
	if (json['From'] != null) {
		data.from = json['From']?.toString();
	}
	if (json['Show'] != null) {
		data.xShow = json['Show']?.toString();
	}
	if (json['Des'] != null) {
		data.des = json['Des']?.toString();
	}
	if (json['Ps'] != null) {
		data.ps = json['Ps']?.toString();
	}
	if (json['Target'] != null) {
		data.target = json['Target']?.toString();
	}
	if (json['Parse'] != null) {
		data.parse = json['Parse']?.toString();
	}
	if (json['Sort'] != null) {
		data.sort = json['Sort']?.toString();
	}
	if (json['Tip'] != null) {
		data.tip = json['Tip']?.toString();
	}
	if (json['ID'] != null) {
		data.iD = json['ID']?.toString();
	}
	return data;
}

Map<String, dynamic> homeDetailBeanVodVodPlayServerToJson(HomeDetailBeanVodVodPlayServer entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['Status'] = entity.status;
	data['From'] = entity.from;
	data['Show'] = entity.xShow;
	data['Des'] = entity.des;
	data['Ps'] = entity.ps;
	data['Target'] = entity.target;
	data['Parse'] = entity.parse;
	data['Sort'] = entity.sort;
	data['Tip'] = entity.tip;
	data['ID'] = entity.iD;
	return data;
}

homeDetailBeanVodVodPlayUrlsFromJson(HomeDetailBeanVodVodPlayUrls data, Map<String, dynamic> json) {
	if (json['bjm3u8'] != null) {
		data.bjm3u8 = new List<List>();
		(json['bjm3u8'] as List).forEach((v) {
			data.bjm3u8.add(v);
		});
	}
	if (json['kuyun'] != null) {
		data.kuyun = new List<List>();
		(json['kuyun'] as List).forEach((v) {
			data.kuyun.add(v);
		});
	}
	if (json['youku'] != null) {
		data.youku = new List<List>();
		(json['youku'] as List).forEach((v) {
			data.youku.add(v);
		});
	}
	if (json['zuidam3u8'] != null) {
		data.zuidam3u8 = new List<List>();
		(json['zuidam3u8'] as List).forEach((v) {
			data.zuidam3u8.add(v);
		});
	}
	return data;
}

Map<String, dynamic> homeDetailBeanVodVodPlayUrlsToJson(HomeDetailBeanVodVodPlayUrls entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	if (entity.bjm3u8 != null) {
		data['bjm3u8'] =  entity.bjm3u8.map((v) => v).toList();
	}
	if (entity.kuyun != null) {
		data['kuyun'] =  entity.kuyun.map((v) => v).toList();
	}
	if (entity.youku != null) {
		data['youku'] =  entity.youku.map((v) => v).toList();
	}
	if (entity.zuidam3u8 != null) {
		data['zuidam3u8'] =  entity.zuidam3u8.map((v) => v).toList();
	}
	return data;
}

homeDetailBeanVodVodClassFromJson(HomeDetailBeanVodVodClass data, Map<String, dynamic> json) {
	if (json['TypeID'] != null) {
		data.typeID = json['TypeID']?.toInt();
	}
	if (json['TypeName'] != null) {
		data.typeName = json['TypeName']?.toString();
	}
	return data;
}

Map<String, dynamic> homeDetailBeanVodVodClassToJson(HomeDetailBeanVodVodClass entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['TypeID'] = entity.typeID;
	data['TypeName'] = entity.typeName;
	return data;
}