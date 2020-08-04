import 'package:shuaishuaimovie/models/hot_rank_bean_entity.dart';
import 'package:shuaishuaimovie/net/request.dart';
import 'package:shuaishuaimovie/viewmodels/base_refresh_model.dart';

abstract class HotRankModel extends BaseRefreshViewModel<MovieRepository> {
 HotRankBeanEntity _hotRankBeanEntity;
 HotRankBeanEntity get hotRankBeanEntity => _hotRankBeanEntity;

  Future<dynamic> getRankApiData() async {
    _hotRankBeanEntity = await requestData(requestRankTypeData());
      if (_hotRankBeanEntity?.status == 0) {
        setSuccess();
      } else {
        setError(new Error(), message: "请求失败");
      }
  }

  Future<dynamic> refreshRankData() async {
    var hotRankBeanEntity = await refreshData(requestRankTypeData());
    if (hotRankBeanEntity != null && hotRankBeanEntity.status == 0) {
      _hotRankBeanEntity = hotRankBeanEntity;
      setSuccess();
      easyRefreshController.resetLoadState();
      easyRefreshController.finishRefresh(success: true);
    } else {
      easyRefreshController.resetLoadState();
      easyRefreshController.finishRefresh(success: false);
    }
  }

  requestRankTypeData();

  @override
  MovieRepository createRepository() {
    return MovieRepository();
  }
}

class WeekRankModel extends HotRankModel {

  @override
  requestRankTypeData() {
   return mRepository.requestRankWeek();
  }
}

class MonthRankModel extends HotRankModel {
  @override
  requestRankTypeData() {
    return mRepository.requestRankMonth();
  }
}

class TotalRankModel extends HotRankModel {
  @override
  requestRankTypeData() {
    return mRepository.requestRankTotal();
  }
}

