import 'package:shuaishuaimovie/generated/json/base/json_convert_content.dart';
import 'package:shuaishuaimovie/generated/json/base/json_filed.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';

class HomeDetailBeanEntity with JsonConvert<HomeDetailBeanEntity> {
	int count;
	String domain;
	List<CommonItemBean> rand;
	List<CommonItemBean> relate;
	String shareLink;
	int status;
	HomeDetailBeanVod vod;
}


class HomeDetailBeanVod with JsonConvert<HomeDetailBeanVod> {
	@JSONField(name: "VodID")
	int vodID;
	@JSONField(name: "VodLevel")
	int vodLevel;
	@JSONField(name: "TypeID")
	int typeID;
	@JSONField(name: "TypeID1")
	int typeID1;
	@JSONField(name: "GroupID")
	int groupID;
	@JSONField(name: "VodUp")
	int vodUp;
	@JSONField(name: "VodName")
	String vodName;
	@JSONField(name: "VodPic")
	String vodPic;
	@JSONField(name: "VodActor")
	String vodActor;
	@JSONField(name: "VodDirector")
	String vodDirector;
	@JSONField(name: "VodBlurb")
	String vodBlurb;
	@JSONField(name: "VodContent")
	String vodContent;
	@JSONField(name: "VodYear")
	String vodYear;
	@JSONField(name: "VodScore")
	int vodScore;
	@JSONField(name: "VodScoreAll")
	int vodScoreAll;
	@JSONField(name: "VodHits")
	int vodHits;
	@JSONField(name: "VodScoreNum")
	int vodScoreNum;
	@JSONField(name: "VodArea")
	String vodArea;
	@JSONField(name: "VodRemarks")
	String vodRemarks;
	@JSONField(name: "Vps")
	String vps;
	@JSONField(name: "Vpf")
	String vpf;
	@JSONField(name: "Vpl")
	String vpl;
	@JSONField(name: "VodHitsWeek")
	String vodHitsWeek;
	@JSONField(name: "VodTime")
	int vodTime;
	@JSONField(name: "VodPlayServer")
	List<HomeDetailBeanVodVodPlayServer> vodPlayServer;
	@JSONField(name: "VodPlayUrls")
	HomeDetailBeanVodVodPlayUrls vodPlayUrls;
	@JSONField(name: "VodClass")
	HomeDetailBeanVodVodClass vodClass;
}

class HomeDetailBeanVodVodPlayServer with JsonConvert<HomeDetailBeanVodVodPlayServer> {
	@JSONField(name: "Status")
	String status;
	@JSONField(name: "From")
	String from;
	@JSONField(name: "Show")
	String xShow;
	@JSONField(name: "Des")
	String des;
	@JSONField(name: "Ps")
	String ps;
	@JSONField(name: "Target")
	String target;
	@JSONField(name: "Parse")
	String parse;
	@JSONField(name: "Sort")
	String sort;
	@JSONField(name: "Tip")
	String tip;
	@JSONField(name: "ID")
	String iD;
}

class HomeDetailBeanVodVodPlayUrls with JsonConvert<HomeDetailBeanVodVodPlayUrls> {
	List<List> bjm3u8;
	List<List> kuyun;
	List<List> youku;
	List<List> zuidam3u8;
}

class HomeDetailBeanVodVodClass with JsonConvert<HomeDetailBeanVodVodClass> {
	@JSONField(name: "TypeID")
	int typeID;
	@JSONField(name: "TypeName")
	String typeName;
}
