import 'package:shuaishuaimovie/models/select_condition_bean_entity.dart';
import 'package:shuaishuaimovie/net/request.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/index_page.dart';
import 'package:shuaishuaimovie/viewmodels/base_model.dart';

class SelectionConditionModel extends BaseViewModel<MovieRepository> {
  SelectionConditionModel(this.tabType, this.classes);

  String tabType;
  String classes;
  String qty = "0";

  void setQty(String qty) {
    this.qty = qty;
    notifyListeners();
  }

  SelectConditionBeanEntity _selectConditionBeanEntity;
  Param _param;

  SelectConditionBeanEntity get selectConditionBeanEntity =>
      _selectConditionBeanEntity;

  Param get param => _param;

  var letters = [
    "全部",
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "0-9"
  ];

  int selectedAreaIndex = 0;
  int selectedLetterIndex = 0;
  int selectedYearIndex = 0;
  int selectedLangIndex = 0;
  int selectedClassIndex = 0;

  int currentPage = 1;

  Future<dynamic> getSelectConditionApiData() async {
    _selectConditionBeanEntity =
        await requestData(mRepository.requestSelectCondition());

    String classes =
        selectTypeName(_selectConditionBeanEntity.types, selectedClassIndex);
    String area =
        selectTypeName(_selectConditionBeanEntity.areas, selectedAreaIndex);
    String year = timeList()[selectedYearIndex].name;
    String lang = _selectConditionBeanEntity.languages[selectedLangIndex].name;
    String letter = letters[selectedLetterIndex];

    String type =
        selectTypeId(_selectConditionBeanEntity.types, selectedClassIndex);
    _param = Param(
        classes: classes,
        area: area,
        year: year,
        lang: lang,
        letter: letter,
        type: type);

    if (_selectConditionBeanEntity?.status == 0) {
      setSuccess();
    } else {
      setError(new Error(), message: "请求失败");
    }
  }

  void setSelectedClassesIndex(int selectedClassesIndex) {
    this.selectedClassIndex = selectedClassesIndex;
    resetStatusParam();
  }

  void setSelectedAreaIndexIndex(int selectedAreaIndex) {
    this.selectedAreaIndex = selectedAreaIndex;
    resetStatusParam();
  }

  void setSelectedLetterIndexIndex(int selectedLetterIndex) {
    this.selectedLetterIndex = selectedLetterIndex;
    resetStatusParam();
  }

  void setSelectedYearIndexIndex(int selectedYearIndex) {
    this.selectedYearIndex = selectedYearIndex;
    resetStatusParam();
  }

  void setSelectedLangIndex(int selectedLangIndex) {
    this.selectedLangIndex = selectedLangIndex;
    resetStatusParam();
  }

  List timeList() {
    List<SelectConditionInnerBean> list = List();
    list.add(SelectConditionInnerBean()..name = "全部");
    for (int i = 2020; i >= 2001; i--) {
      list.add(SelectConditionInnerBean()..name = i.toString());
    }
    return list;
  }

  List<SelectConditionInnerBean> letterList() {
    List<SelectConditionInnerBean> list = List();
    for (int i = 0; i < letters.length; i++) {
      list.add(SelectConditionInnerBean()..name = letters[i]);
    }
    return list;
  }

  List selectedList(String defaultTxt) {
    List<String> list = List();
    list.add(defaultTxt);
    if (classes.isNotEmpty) {
      List list;
      if (tabType == IndexPage.TAB_SHOW) {
        list = _selectConditionBeanEntity.areas.show;
      } else {
        list = getTypeList(_selectConditionBeanEntity.types);
      }
      if (list != null) {
        for (int i = 0; i < list.length; i++) {
          if (list[i].name == classes) {
            if (tabType == IndexPage.TAB_SHOW) {
              selectedAreaIndex = i;
            } else {
              selectedClassIndex = i;
            }
            break;
          }
        }
      }
    }
    classes = "";
    if (selectedLangIndex != 0) {
      list.add(_selectConditionBeanEntity.languages[selectedLangIndex].name);
    }
    if (selectedYearIndex != 0) {
      list.add(timeList()[selectedYearIndex].name);
    }

    if (selectedAreaIndex != 0) {
      list.add(
          selectTypeName(_selectConditionBeanEntity.areas, selectedAreaIndex));
    }

    if (selectedClassIndex != 0) {
      list.add(
          selectTypeName(_selectConditionBeanEntity.types, selectedClassIndex));
    }

    if (selectedLetterIndex != 0) {
      list.add(letters[selectedLetterIndex]);
    }

    return list;
  }

  void resetStatusParam(
      {int classIndex,
      int areaIndex,
      int letterIndex,
      int yearIndex,
      int langIndex}) {
    selectedClassIndex = classIndex ?? selectedClassIndex;
    selectedAreaIndex = areaIndex ?? selectedAreaIndex;
    selectedLetterIndex = letterIndex ?? selectedLetterIndex;
    selectedYearIndex = yearIndex ?? selectedYearIndex;
    selectedLangIndex = langIndex ?? selectedLangIndex;
    qty = "0";

    String classes =
        selectTypeName(_selectConditionBeanEntity.types, selectedClassIndex);
    String area =
        selectTypeName(_selectConditionBeanEntity.areas, selectedAreaIndex);
    String year = timeList()[selectedYearIndex].name;
    String lang = _selectConditionBeanEntity.languages[selectedLangIndex].name;
    String letter = letters[selectedLetterIndex];
    String type =
        selectTypeId(_selectConditionBeanEntity.types, selectedClassIndex);
    _param = Param(
        classes: classes,
        area: area,
        year: year,
        lang: lang,
        letter: letter,
        type: type);
    notifyListeners();
  }

  String selectTypeName(SelectConditionCommonBean data, int index) {
    switch (tabType) {
      case IndexPage.TAB_MOVIE:
        return data.movie != null && data.movie.length > 0
            ? data.movie[index].name
            : "全部";
      case IndexPage.TAB_CARTOON:
        return data.cartoon != null && data.cartoon.length > 0
            ? data.cartoon[index].name
            : "全部";
      case IndexPage.TAB_SHOW:
        return data.show != null && data.show.length > 0
            ? data.show[index].name
            : "全部";
      case IndexPage.TAB_TELEPLAY:
        return data.teleplay != null && data.teleplay.length > 0
            ? data.teleplay[index].name
            : "全部";
        break;
      default:
        return "";
    }
  }

  String selectTypeId(SelectConditionCommonBean data, int index) {
    switch (tabType) {
      case IndexPage.TAB_MOVIE:
        return data.movie != null && data.movie.length > 0
            ? data.movie[index].id.toString()
            : "1";
      case IndexPage.TAB_CARTOON:
        return data.cartoon != null && data.cartoon.length > 0
            ? data.cartoon[index].id.toString()
            : "4";
      case IndexPage.TAB_SHOW:
        return data.show != null && data.show.length > 0
            ? data.show[index].id.toString()
            : "3";
      case IndexPage.TAB_TELEPLAY:
        return data.teleplay != null && data.teleplay.length > 0
            ? data.teleplay[index].id.toString()
            : "2";
        break;
      default:
        return "";
    }
  }

  List<SelectConditionInnerBean> getTypeList(SelectConditionCommonBean data) {
    switch (tabType) {
      case IndexPage.TAB_MOVIE:
        return data.movie;
      case IndexPage.TAB_CARTOON:
        return data.cartoon;
      case IndexPage.TAB_SHOW:
        return data.show;
      case IndexPage.TAB_TELEPLAY:
        return data.teleplay;
        break;
      default:
        return null;
    }
  }

  @override
  MovieRepository createRepository() {
    return MovieRepository();
  }
}

class Param {
  Param(
      {this.classes, this.area, this.year, this.lang, this.letter, this.type});

  String classes;
  String area;
  String year;
  String lang;
  String letter;
  String type;
}
