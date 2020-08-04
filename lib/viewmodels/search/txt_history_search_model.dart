import 'package:shuaishuaimovie/database/sqf_provider.dart';
import 'package:shuaishuaimovie/viewmodels/base_model.dart';
import 'package:shuaishuaimovie/database/bean/search_history_bean.dart'
as historySearch;

class TxtHistorySearchModel extends BaseViewModel {
  List<Map<String, dynamic>> _historySearchList;
  bool _isShowCloseIcon = false;
  
  String get columnName => historySearch.columnName;
  List<Map<String, dynamic>> get historySearchList => _historySearchList;
  bool get isShowCloseIcon => _isShowCloseIcon;

  void getLocalHistorySearchData() async {
    await SqfProvider.db.query(historySearch.tableName, orderBy: 'id desc').then((value) {
      _historySearchList =  List.from(value);
      notifyListeners();
    });

  }

  void delSearchHistoryData(int index) {
      SqfProvider.db.delete(historySearch.tableName,
          where: 'id=${_historySearchList[index]['id']}');
      _historySearchList.removeAt(index);
      if (_historySearchList.length == 0) {
        changeShowCloseStatus();
      }
  }

  void delSearchHistoryAllDatas() {
      SqfProvider.db.delete(historySearch.tableName);
      _historySearchList.clear();
      changeShowCloseStatus();
  }
  
  void changeShowCloseStatus() {
    _isShowCloseIcon = !_isShowCloseIcon;
    notifyListeners();
  }

}