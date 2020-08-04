

final String tableName = "search_history_table";
final String columnName = 'name';

class SearchHistoryBean {
  String name;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
    };

    return map;
  }
}

