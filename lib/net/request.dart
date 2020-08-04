import 'package:dio/dio.dart';
import 'package:shuaishuaimovie/models/common_tab_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/condition_search_bean_entity.dart';
import 'package:shuaishuaimovie/models/home_detail_bean_entity.dart';
import 'package:shuaishuaimovie/models/home_list_bean_entity.dart';
import 'package:shuaishuaimovie/models/hot_rank_bean_entity.dart';
import 'package:shuaishuaimovie/models/hot_update_bean_entity.dart';
import 'package:shuaishuaimovie/models/select_condition_bean_entity.dart';
import 'package:shuaishuaimovie/models/txt_auto_search_bean_entity.dart';
import 'package:shuaishuaimovie/net/base_repository.dart';
import 'package:shuaishuaimovie/net/request_helper.dart';

import 'request_const.dart';

class MovieRepository extends BaseRepository {
  Dio dio = HttpHelper.instance.getDio();

  MovieRepository() {
    setDio(dio);
  }

  Future<dynamic> requestHomeList() async {
    return await get(RequestConstApi.HOME_API).then((baseResult) {
      if(baseResult.code == 0) {
        return HomeListBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestHomeDetail(String vodId) async {
    var homeDetailParam = Map<String, dynamic>();
    homeDetailParam["id"] = vodId;
    print(RequestConstApi.HOME_DETAIL_API + "?id=${vodId}");
    return await get(RequestConstApi.HOME_DETAIL_API + "?id=${vodId}").then((baseResult) {
      if(baseResult.code == 0) {
        return HomeDetailBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestHotUpdate() async{
    return await get(RequestConstApi.HOT_UPDATE_API).then((baseResult) {
      if(baseResult.code == 0) {
        return HotUpdateBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestRankWeek() async{
    return await get(RequestConstApi.RANK_WEEK_API).then((baseResult) {
      if(baseResult.code == 0) {
        return HotRankBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestRankMonth() async{
    return await get(RequestConstApi.RANK_MONTH_API).then((baseResult) {
      if(baseResult.code == 0) {
        return HotRankBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestRankTotal() async{
    return await get(RequestConstApi.RANK_TOTAL_API).then((baseResult) {
      if(baseResult.code == 0) {
        return HotRankBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestMovie() async{
    return await get(RequestConstApi.MOVIE_API).then((baseResult) {
      if(baseResult.code == 0) {
        return CommonTabItemBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestTeleplay() async{
    return await get(RequestConstApi.TELEPLAY_API).then((baseResult) {
      if(baseResult.code == 0) {
        return CommonTabItemBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestShow() async{
    return await get(RequestConstApi.SHOW_API).then((baseResult) {
      if(baseResult.code == 0) {
        return CommonTabItemBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestCartoon() async{
    return await get(RequestConstApi.CARTOON_API).then((baseResult) {
      if(baseResult.code == 0) {
        return CommonTabItemBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestSelectCondition() async{
    return await get(RequestConstApi.SELECT_CONDITION_API).then((baseResult) {
      if(baseResult.code == 0) {
        return SelectConditionBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestConditionSearch({String orderBy, String type, String classes, String area, String year, String lang, String letter, String page}) async{
    String param = "orderBy=$orderBy&type=$type&class=$classes&area=$area&year=$year&lang=$lang&letter=$letter&page=$page";
    print(RequestConstApi.CONDITION_SEARCH_API + param);
    return await get(RequestConstApi.CONDITION_SEARCH_API + param).then((baseResult) {
      if(baseResult.code == 0) {
        return ConditionSearchBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestAutoSearch(String keyword) async{
    String param = "keyword=$keyword";
    print(RequestConstApi.TXT_AUTO_SEARCH_API + param);
    return await get(RequestConstApi.TXT_AUTO_SEARCH_API + param).then((baseResult) {
      if(baseResult.code == 0) {
        return TxtAutoSearchBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }

  Future<dynamic> requestNormalSearch({String keyword, String page}) async{
    String param = "keyword=$keyword&cate=undefined&page=$page";
    print(RequestConstApi.TXT_NORMAL_SEARCH_API + param);
    return await get(RequestConstApi.TXT_NORMAL_SEARCH_API + param).then((baseResult) {
      if(baseResult.code == 0) {
        return ConditionSearchBeanEntity().fromJson(baseResult.data);
      } else {
        return null;
      }
    });
  }
}

