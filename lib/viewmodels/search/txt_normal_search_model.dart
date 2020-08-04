import 'package:shuaishuaimovie/database/bean/search_history_bean.dart';
import 'package:shuaishuaimovie/database/bean/search_history_bean.dart'
    as historySearch;
import 'package:shuaishuaimovie/database/sqf_provider.dart';
import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/condition_search_bean_entity.dart';
import 'package:shuaishuaimovie/net/request.dart';
import 'package:shuaishuaimovie/viewmodels/base_refresh_model.dart';

class NormalSearchModel extends BaseRefreshViewModel<MovieRepository> {
  ConditionSearchBeanEntity _conditionSearchBeanEntity;

  List<CommonItemBean> get conditionSearchBeanDatas =>
      _conditionSearchBeanEntity?.data;

  int get qty => _conditionSearchBeanEntity?.qty ?? 0;

  int currentPage = 1;
  bool isLoadingMore = false;
  String keyword;

  Future<dynamic> getNormalSearchApiData(String keyword) async {
    this.keyword = keyword;
    _conditionSearchBeanEntity =
        await requestData(mRepository.requestNormalSearch(
      keyword: keyword,
      page: currentPage.toString(),
    ));

    if (_conditionSearchBeanEntity?.status == 0) {
      if (_conditionSearchBeanEntity.data == null) {
        setEmpty();
      } else {
        //将搜索成功的数据存入数据库中
        insertHistorySearchDBTxt(keyword);
        setSuccess();
      }
    } else {
      setError(new Error(), message: "请求失败");
    }
  }

  Future<dynamic> loadMoreNormalSearchData() async {
    if (isLoadingMore) return;

    //默认每一页36条数据
    if (currentPage >= (qty / 36.toDouble()).ceil()) {
      easyRefreshController.resetLoadState();
      easyRefreshController.finishLoad(noMore: true);
      return;
    }

    isLoadingMore = true;
    var conditionSearchBeanEntity =
        await loadMoreData(mRepository.requestNormalSearch(
      keyword: keyword,
      page: (currentPage + 1).toString(),
    ));
    if (conditionSearchBeanEntity?.status == 0) {
      _conditionSearchBeanEntity.data.addAll(conditionSearchBeanEntity.data);
      currentPage++;
      easyRefreshController.resetLoadState();
      easyRefreshController.finishLoad(success: true);
    } else {
      easyRefreshController.resetLoadState();
      easyRefreshController.finishLoad(success: false);
    }
    isLoadingMore = false;
    notifyListeners();
  }

  void insertHistorySearchDBTxt(String searchTxt) async {
    await SqfProvider.db.transaction((txn) async {
      //如果当前搜索条件在table中，跳过再一次存储
      List list = await txn.query(historySearch.tableName,
          distinct: false,
          orderBy: 'id desc',
          columns: [historySearch.columnName],
          where: '${historySearch.columnName}=?',
          whereArgs: [searchTxt]);
      print(list.length);
      if (list.length > 0) return;
      SearchHistoryBean searchHistoryBean = SearchHistoryBean();
      searchHistoryBean.name = searchTxt;
      await txn.insert(historySearch.tableName, searchHistoryBean.toMap());
      List results = await txn.rawQuery(
        'SELECT id FROM ${historySearch.tableName}',
      );
      //默认只存16条数据
      for(int i = 0; i < results.length - 16; i++) {
        await txn.delete(historySearch.tableName, where: 'id=${results[i]['id']}');
      }
    });
  }

  @override
  MovieRepository createRepository() {
    return MovieRepository();
  }
}
