import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:shuaishuaimovie/net/base_repository.dart';
import 'package:shuaishuaimovie/viewmodels/base_model.dart';

abstract class BaseRefreshViewModel<T extends BaseRepository>
    extends BaseViewModel<T> {

  EasyRefreshController _easyRefreshController = EasyRefreshController();
  EasyRefreshController get easyRefreshController => _easyRefreshController;

  /// 通用请求数据方法 子类可以复写
  Future<dynamic> refreshData(Future<dynamic> requestApi) async {
    var result;
    try {
      result = await requestApi;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<dynamic> loadMoreData(Future<dynamic> requestApi) async {
    var result;
    try {
      result = await requestApi;
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

}
