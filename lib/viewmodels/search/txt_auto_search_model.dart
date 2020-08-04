import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/txt_auto_search_bean_entity.dart';
import 'package:shuaishuaimovie/net/request.dart';
import 'package:shuaishuaimovie/viewmodels/base_model.dart';

class TxtAutoSearchModel extends BaseViewModel<MovieRepository> {
  TxtAutoSearchBeanEntity _autoSearchBeanEntity;

  List<CommonItemBean> get txtAutoSearchBeanDatas =>
      _autoSearchBeanEntity?.data;

  Future<dynamic> getTxtAutoSearchApiData(String keyword) async {
    _autoSearchBeanEntity =
        await requestNoStatusData(mRepository.requestAutoSearch(keyword));
    if (_autoSearchBeanEntity?.status == 0) {
      setSuccess();
    }
  }

  void clearData() {
    _autoSearchBeanEntity = null;
  }

  List processedTxt(String str, String highTxt) {
    List<String> list = List();
    if(str.contains(highTxt)) {
      var preTxt = str.split(highTxt)[0];
      return list..add(preTxt)..add(highTxt)..add(
          str.replaceFirst(preTxt + highTxt, ""));
    } else {
      return list..add(str);
    }
  }

  @override
  MovieRepository createRepository() {
    return MovieRepository();
  }
}
