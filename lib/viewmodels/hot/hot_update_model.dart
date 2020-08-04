import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/hot_update_bean_entity.dart';
import 'package:shuaishuaimovie/net/request.dart';
import 'package:shuaishuaimovie/viewmodels/base_refresh_model.dart';

class HotUpdateModel extends BaseRefreshViewModel<MovieRepository> {
  HotUpdateBeanEntity _hotUpdateBeanEntity;

  List<CommonItemBean> get hotUpdateBeanDatas => _hotUpdateBeanEntity.data;

  int currentPage = 0;

  List<CommonItemBean> get currentHotDatas => _currentHotDatas;
  List<CommonItemBean> _currentHotDatas;

  int get hotUpdateTotals => hotUpdateBeanDatas.length ~/ 20;

  Future<dynamic> getHotUpdateApiData() async {
    _hotUpdateBeanEntity = await requestData(mRepository.requestHotUpdate());
    if (_hotUpdateBeanEntity?.status == 0) {
      refreshLocalData(true);
      setSuccess();
    } else {
      setError(new Error(), message: "请求失败");
    }
  }

  Future<dynamic> refreshHotUpdateData() async {
    var hotUpdateBeanEntity = await refreshData(mRepository.requestHotUpdate());
    if (hotUpdateBeanEntity != null && hotUpdateBeanEntity.status == 0) {
      _hotUpdateBeanEntity = hotUpdateBeanEntity;
      refreshLocalData(true);
      setSuccess();
      easyRefreshController.resetLoadState();
      easyRefreshController.finishRefresh(success: true);
    } else {
      easyRefreshController.resetLoadState();
      easyRefreshController.finishRefresh(success: false);
    }
  }

  void refreshLocalData([bool initFlag = false]) {
    if (initFlag) {
      currentPage = 0;
      _currentHotDatas = hotUpdateBeanDatas.sublist(0, 20);
      return;
    }
    currentPage = currentPage >= hotUpdateTotals - 1 ? 0 : currentPage + 1;
    _currentHotDatas =
        hotUpdateBeanDatas.sublist(currentPage * 20, currentPage * 20 + 20);
    notifyListeners();
  }

  @override
  MovieRepository createRepository() {
    return MovieRepository();
  }
}
