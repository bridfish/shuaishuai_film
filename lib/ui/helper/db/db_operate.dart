import 'package:shuaishuaimovie/database/bean/search_history_bean.dart';
import 'package:shuaishuaimovie/database/sqf_provider.dart';
import 'package:shuaishuaimovie/database/bean/search_history_bean.dart' as historySearch;

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