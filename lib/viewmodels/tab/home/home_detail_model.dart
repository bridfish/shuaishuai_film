import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/home_detail_bean_entity.dart';
import 'package:shuaishuaimovie/net/request.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/viewmodels/base_model.dart';

class HomeDetailViewModel extends BaseViewModel<MovieRepository> {
  HomeDetailBeanEntity _homeDetailBeanEntity;
  String _playUrlType;

  HomeDetailBeanEntity get homeDetailBeanEntity => _homeDetailBeanEntity;

  HomeDetailBeanVod get homeDetailBeanVod => _homeDetailBeanEntity.vod;

  List<CommonItemBean> get homeDetailBeanRands => _homeDetailBeanEntity.rand;

  List<CommonItemBean> get homeDetailBeanRelate => _homeDetailBeanEntity.relate;

  String get playUrlType => _playUrlType;

  List<List> get playUrls {
    //todo临时解决的，后期在通过数据看看能不能进一步优化。因为数据是抓的，所以先遍历最常用的
    var list;
    _playUrlType = "bjm3u8";
    list = homeDetailBeanVod.vodPlayUrls.toJson()[_playUrlType];
    if(list != null) return list;

    _playUrlType = "zuidam3u8";
    list = homeDetailBeanVod.vodPlayUrls.toJson()[_playUrlType];
    if(list != null) return list;

    _playUrlType = "zkm3u8";
    list = homeDetailBeanVod.vodPlayUrls.toJson()[_playUrlType];
    if(list != null) return list;

    _playUrlType = "dbm3u8";
    list = homeDetailBeanVod.vodPlayUrls.toJson()[_playUrlType];
    if(list != null) return list;

    _playUrlType = homeDetailBeanVod.vodPlayServer?.last?.iD;
    return _playUrlType == null ? null : homeDetailBeanVod.vodPlayUrls.toJson()[_playUrlType];

  }

  Color bgColor = AppColor.white;

  @override
  MovieRepository createRepository() {
    return MovieRepository();
  }

  Future<dynamic> getHomeDetailApiData(String vodId) async {
    if (!await checkNet()) {
      setNoNetWork();
      return null;
    }
    _homeDetailBeanEntity =
        await requestData(mRepository.requestHomeDetail(vodId));
      if (_homeDetailBeanEntity?.status == 0) {
        setSuccess();
      } else {
        setError(new Error(), message: "请求失败");
    }
  }

  void setBgColor(Color bgColor) {
    this.bgColor = bgColor;
    notifyListeners();
  }
}
