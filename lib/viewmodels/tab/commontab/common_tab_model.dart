import 'package:shuaishuaimovie/models/common_tab_item_bean_entity.dart';
import 'package:shuaishuaimovie/net/request.dart';
import 'package:shuaishuaimovie/viewmodels/base_refresh_model.dart';

abstract class CommonTabModel extends BaseRefreshViewModel<MovieRepository> {
  CommonTabItemBeanEntity _commonTabItemBeanEntity;

  CommonTabItemBeanEntity get commonTabItemBeanEntity =>
      _commonTabItemBeanEntity;

  Future<dynamic> getCommonTabApiData() async {
    _commonTabItemBeanEntity = await requestData(requestTabTypeData());
    if (_commonTabItemBeanEntity?.status == 0) {
      setSuccess();
    } else {
      setError(new Error(), message: "请求失败");
    }
  }

  Future<dynamic> refreshCommonTabData() async {
    var commonTabItemBeanEntity = await refreshData(requestTabTypeData());
    if (commonTabItemBeanEntity != null &&
        commonTabItemBeanEntity.status == 0) {
      _commonTabItemBeanEntity = commonTabItemBeanEntity;
      setSuccess();
      easyRefreshController.resetLoadState();
      easyRefreshController.finishRefresh(success: true);
    } else {
      easyRefreshController.resetLoadState();
      easyRefreshController.finishRefresh(success: false);
    }
  }

  requestTabTypeData();

  @override
  MovieRepository createRepository() {
    return MovieRepository();
  }
}

class MovieTabModel extends CommonTabModel {
  @override
  requestTabTypeData() {
    return mRepository.requestMovie();
  }
}

class TeleplayTabModel extends CommonTabModel {
  @override
  requestTabTypeData() {
    return mRepository.requestTeleplay();
  }
}

class ShowTabModel extends CommonTabModel {
  @override
  requestTabTypeData() {
    return mRepository.requestShow();
  }
}

class CartoonModel extends CommonTabModel {
  @override
  requestTabTypeData() {
    return mRepository.requestCartoon();
  }
}
