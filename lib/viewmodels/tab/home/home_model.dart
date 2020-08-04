import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/home_list_bean_entity.dart';
import 'package:shuaishuaimovie/net/request.dart';
import 'package:shuaishuaimovie/viewmodels/base_refresh_model.dart';

class HomeViewModel extends BaseRefreshViewModel<MovieRepository> {
  HomeListBeanEntity _homeListBeanEntity;

  HomeListBeanEntity get homeListBeanEntity => _homeListBeanEntity;

  List<CommonItemBean> get homeHotBeans => _homeListBeanEntity.h;

  List<CommonItemBean> get homeMovieBeans => _homeListBeanEntity.m;

  List<CommonItemBean> get homeSitcomBeans => _homeListBeanEntity.t;

  List<CommonItemBean> get homeVarietyBeans => _homeListBeanEntity.s;

  List<CommonItemBean> get homeAnimatedBeans => _homeListBeanEntity.c;

  //用来重置home页面的最热数据，
  bool isRequestApi = false;

  void setRequestApi(bool isRequestApi) {
    this.isRequestApi = isRequestApi;
  }

  getHomeListApiData() async {
    _homeListBeanEntity = await requestData(mRepository.requestHomeList());
      if (_homeListBeanEntity?.status == 0) {
        isRequestApi = true;
        setSuccess();
      } else {
        setError(new Error(), message: "请求失败");
    }
  }

  Future<void> refreshHomeListData() async {
    var homeListBeanEntity = await refreshData(mRepository.requestHomeList());
    if (homeListBeanEntity != null && homeListBeanEntity.status == 0) {
      _homeListBeanEntity = homeListBeanEntity;
      isRequestApi = true;
      setSuccess();
      easyRefreshController.resetLoadState();
      easyRefreshController.finishRefresh(success: true);
    } else {
      easyRefreshController.resetLoadState();
      easyRefreshController.finishRefresh(success: false);
    }
  }


  @override
  MovieRepository createRepository() {
    return MovieRepository();
  }
}
