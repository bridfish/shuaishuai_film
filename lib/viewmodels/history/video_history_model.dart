import 'package:shuaishuaimovie/database/bean/video_history_bean.dart'
    as videoHistory;
import 'package:shuaishuaimovie/database/sqf_provider.dart';
import 'package:shuaishuaimovie/viewmodels/base_model.dart';

class VideoHistoryModel extends BaseViewModel {
  List<Map<String, dynamic>> _todayVideoHistoryList;
  List<Map<String, dynamic>> _yesterdayVideoHistoryList;
  List<Map<String, dynamic>> _moreDayVideoHistoryList;

  bool _isFilter = false;
  bool _isEdit = false;
  bool _isAllChecked = false;

  //用于存储选中的数据
  Map<int, bool> _checkedMap = Map();

  bool get isFilter => _isFilter;

  bool get isEdit => _isEdit;

  bool get isAllChecked => _isAllChecked;

  Map<int, bool> get checkedMap => _checkedMap;

  List<Map<String, dynamic>> get todayVideoHistoryList =>
      _filterVideoHistoryData(_todayVideoHistoryList, _isFilter);

  List<Map<String, dynamic>> get yesterdayVideoHistoryList =>
      _filterVideoHistoryData(_yesterdayVideoHistoryList, _isFilter);

  List<Map<String, dynamic>> get moreDayVideoHistoryList =>
      _filterVideoHistoryData(_moreDayVideoHistoryList, _isFilter);

  void readLocalVideoHistoryData() async {
    final todayTime = _getTodayMilliseconds();
    SqfProvider.getTables().then((value) => print(value));
    await SqfProvider.db.transaction((txn) async {
      //获取今天的数据
      var todayVideoHistoryList = await txn.query(videoHistory.tableName,
          orderBy: 'milliseconds desc',
          where: '${videoHistory.columnMilliseconds}>=?',
          whereArgs: [todayTime]);
      print(todayVideoHistoryList.length);
      _todayVideoHistoryList = List.from(todayVideoHistoryList);

      //获取昨天的数据
      var yesterdayVideoHistoryList = await txn.query(videoHistory.tableName,
          orderBy: 'milliseconds desc',
          where:
              '${videoHistory.columnMilliseconds}>=? and ${videoHistory.columnMilliseconds}<?',
          whereArgs: [todayTime - 1000 * 60 * 60 * 24, todayTime]);
      print(yesterdayVideoHistoryList.length);
      _yesterdayVideoHistoryList = List.from(yesterdayVideoHistoryList);

      //获取更早的数据
      var moreDayVideoHistoryList = await txn.query(videoHistory.tableName,
          orderBy: 'milliseconds desc',
          where: '${videoHistory.columnMilliseconds}<?',
          whereArgs: [todayTime - 1000 * 60 * 60 * 24]);
      print(moreDayVideoHistoryList.length);
      _moreDayVideoHistoryList = List.from(moreDayVideoHistoryList);
    });

    //进行判断有没有历史数据
    if (isNotEmptyData()) {
      setSuccess();
    } else {
      setEmpty();
    }
  }

  bool isNotEmptyData() {
    return (todayVideoHistoryList != null &&
            todayVideoHistoryList.length > 0) ||
        (yesterdayVideoHistoryList != null &&
            yesterdayVideoHistoryList.length > 0) ||
        (moreDayVideoHistoryList != null && moreDayVideoHistoryList.length > 0);
  }

  void onFilterTap() {
    _isFilter = !_isFilter;
    if (isNotEmptyData()) {
      setSuccess();
    } else {
      setEmpty();
    }
  }

  void onEditTap() {
    _isEdit = !_isEdit;
    //编辑的时候先清空存储的数据
    if (_isEdit) _clearCheckData();
  }

  int _getTodayMilliseconds() {
    var date = DateTime.now();
    print(DateTime.now().millisecondsSinceEpoch -
        DateTime(date.year, date.month, date.day, 0, 0, 0)
            .millisecondsSinceEpoch);
    return DateTime(date.year, date.month, date.day, 0, 0, 0)
        .millisecondsSinceEpoch;
  }

  List<Map<String, dynamic>> _filterVideoHistoryData(
      List<Map<String, dynamic>> list, bool isFilter) {
    if (isFilter) {
      return List.from(list)
        ..removeWhere((value) {
          return value[videoHistory.columnCurrentPlayTime] >=
              value[videoHistory.columnTotalPlayTime] - 5 * 1000;
        });
    } else {
      return List.from(list);
    }
  }

  void operateCheckData(int index, bool value) {
    if (value) {
      _checkedMap[index] = value;
    } else {
      if (isHasCheckedData(index)) _checkedMap.remove(index);
    }
  }

  bool isHasCheckedData(int index) {
    return _checkedMap.containsKey(index);
  }

  void _clearCheckData() {
    _checkedMap.clear();
  }

  void operateAllCheckData() {
    _clearCheckData();
    var list = List()
      ..addAll(todayVideoHistoryList)
      ..addAll(yesterdayVideoHistoryList)
      ..addAll(moreDayVideoHistoryList);

    _isAllChecked = !_isAllChecked;
    if (isAllChecked) {
      for (int i = 0; i < list.length; i++) {
        _checkedMap[i] = true;
      }
    }
    notifyListeners();
  }

  void delCheckedData() {
    final keyList = _checkedMap.keys.toList()
      ..sort((a, b) {
        return a - b;
      });
    print(keyList.toString());
    for (int i = keyList.length - 1; i >= 0; i--) {
      var key = keyList[i];
      var delData;
      if (_todayVideoHistoryList.length > key) {
        delData = _todayVideoHistoryList[key];
        _todayVideoHistoryList.removeAt(key);
      } else if (_yesterdayVideoHistoryList.length +
              _todayVideoHistoryList.length >
          key) {
        key = key - _todayVideoHistoryList.length;
        delData = _yesterdayVideoHistoryList[key];
        _yesterdayVideoHistoryList.removeAt(key);
      } else if (_moreDayVideoHistoryList.length +
              _todayVideoHistoryList.length +
              _yesterdayVideoHistoryList.length >
          key) {
        key = key -
            _todayVideoHistoryList.length -
            _yesterdayVideoHistoryList.length;
        print("$key........${_moreDayVideoHistoryList.length}");
        delData = _moreDayVideoHistoryList[key];
        _moreDayVideoHistoryList.removeAt(key);
      }
      if (delData != null) {
        SqfProvider.db.delete(videoHistory.tableName,
            where:
                '${videoHistory.columnVideoId}=${delData[videoHistory.columnVideoId]}');
      }
    }

    _clearCheckData();
    if (isNotEmptyData()) {
      setSuccess();
    } else {
      setEmpty();
    }
  }

  dynamic getCurrentItem(int index) {
    final todayLength =
        todayVideoHistoryList == null ? 0 : todayVideoHistoryList.length;
    final yesterdayLength = yesterdayVideoHistoryList == null
        ? 0
        : yesterdayVideoHistoryList.length;
    final moreDayLength =
        moreDayVideoHistoryList == null ? 0 : moreDayVideoHistoryList.length;
    var bean;
    if (index < todayLength) {
      bean = todayVideoHistoryList[index];
    } else if (index < todayLength + yesterdayLength) {
      bean = yesterdayVideoHistoryList[index - todayLength];
    } else if (index < todayLength + yesterdayLength + moreDayLength) {
      bean = moreDayVideoHistoryList[index - todayLength - yesterdayLength];
    }
    return bean;
  }

  //todo 用于测试做的假数据，后期会删掉
  Future createLocalData() async {
    await SqfProvider.db.delete(videoHistory.tableName);
    for (int i = 0; i < 10; i++) {
      videoHistory.VideoHistoryBean videoHistoryBean =
          videoHistory.VideoHistoryBean();
      videoHistoryBean
        ..milliseconds =
            DateTime.now().millisecondsSinceEpoch - 1000 * 60 * 60 * i
        ..totalPlayTime = 1000000000000
        ..currentPlayTime = 1000000000000 - 1000 * 5 + 1000 * i
        ..updateInfo = "更新多个...$i"
        ..videoName = "万界升值"
        ..videoId = i
        ..picUrl =
            "https://cdn.aqdstatic.com:966/88ys/upload/vod/2020-07/159464280295685964.jpg";
      await SqfProvider.db
          .insert(videoHistory.tableName, videoHistoryBean.toMap());
    }
  }
}
