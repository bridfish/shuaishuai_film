import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'bean/search_history_bean.dart' as searchHistoryTable;
import 'bean/video_history_bean.dart' as videoHistoryTable;

class SqfProvider {
  static Database db;
  static const int DB_VERSION = 1;

  static Future initSQF() async {
    String databasesPath = await getDatabasesPath();
    // Database Path: /data/user/0/com.package.name/databases
    String path = join(databasesPath, 'shuaishuai_movie.db');
    // Path: /data/user/0/com.example.shuaishuaimovie/databases/shuaishuai_movie.db
    db = await openDatabase(
      path,
      version: DB_VERSION,
      onCreate: (Database db, int version) async {
        // 表格创建等初始化操作, 因为该项目的表格需要的不多，所以就一次性创建
       await db.execute(
            'CREATE TABLE ${searchHistoryTable.tableName} (id INTEGER PRIMARY KEY, ${searchHistoryTable.columnName} TEXT)');
       await db.execute(
            'CREATE TABLE ${videoHistoryTable.tableName} (id INTEGER PRIMARY KEY, ${videoHistoryTable.columnVideoName} TEXT, ${videoHistoryTable.columnPicUrl} TEXT, ${videoHistoryTable.columnUpdateInfo} TEXT, ${videoHistoryTable.columnVideoLevel} TEXT, ${videoHistoryTable.columnPlayUrlType} TEXT, ${videoHistoryTable.columnVideoId} INTEGER, ${videoHistoryTable.columnCurrentPlayTime} INTEGER, ${videoHistoryTable.columnTotalPlayTime} INTEGER, ${videoHistoryTable.columnMilliseconds} INTEGER, ${videoHistoryTable.columnPlayUrlIndex} INTEGER)')
       .catchError((error) {
         print(error);
       });
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        // 数据库升级
      },
    );
  }

  // 获取数据库中所有的表
  static Future<List> getTables() async {
    if (db == null) {
      return Future.value([]);
    }
    List tables = await db
        .rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
    List<String> targetList = [];
    tables.forEach((item) {
      targetList.add(item['name']);
    });
    return targetList;
  }
}
