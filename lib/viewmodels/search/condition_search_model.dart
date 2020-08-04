import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/condition_search_bean_entity.dart';
import 'package:shuaishuaimovie/models/select_condition_bean_entity.dart';
import 'package:shuaishuaimovie/net/request.dart';
import 'package:shuaishuaimovie/ui/pages/maintab/index_page.dart';
import 'package:shuaishuaimovie/viewmodels/base_refresh_model.dart';
import 'package:shuaishuaimovie/viewmodels/search/select_condition_model.dart';

class HotConditionModel extends ConditionSearchModel {
  HotConditionModel(String tabType) : super(tabType);
  String orderBy = "hot";
}

class TimeConditionModel extends ConditionSearchModel {
  TimeConditionModel(String tabType) : super(tabType);
  String orderBy = "time";
}

class ScoreConditionModel extends ConditionSearchModel {
  ScoreConditionModel(String tabType) : super(tabType);
  String orderBy = "score";
}

abstract class ConditionSearchModel
    extends BaseRefreshViewModel<MovieRepository> {
  ConditionSearchModel(this.tabType);

  SelectionConditionModel _selectionConditionModel;

  SelectionConditionModel get selectionConditionModel =>
      _selectionConditionModel;

  set selectionConditionModel(
      SelectionConditionModel newSelectionConditionModel) {
    _selectionConditionModel = newSelectionConditionModel;
  }

  String tabType;
  String orderBy = "";

  //easyrefresh bug
  //在上拉加载的时候接着上拉还会请求数据。
  bool isLoadingMore = false;

  ConditionSearchBeanEntity _conditionSearchBeanEntity;

  List<CommonItemBean> get conditionSearchBeanDatas =>
      _conditionSearchBeanEntity.data;

  int get qty => _conditionSearchBeanEntity?.qty ?? 0;

  int currentPage = 1;

  Future<dynamic> getConditionSearchApiData() async {
    print(selectionConditionModel);
    _conditionSearchBeanEntity =
        await requestData(mRepository.requestConditionSearch(
      orderBy: orderBy,
      type: selectionConditionModel.param.type,
      classes: selectionConditionModel.param.classes,
      area: selectionConditionModel.param.area,
      year: selectionConditionModel.param.year,
      lang: selectionConditionModel.param.lang,
      letter: selectionConditionModel.param.letter,
      page: currentPage.toString(),
    ));

    if (_conditionSearchBeanEntity != null) {
      if (_conditionSearchBeanEntity.status == 0) {
        selectionConditionModel.setQty(this.qty.toString());
        if (_conditionSearchBeanEntity.data == null) {
          setEmpty();
        } else {
          setSuccess();
        }
      } else {
        setError(new Error(), message: "请求失败");
      }
    }
  }

  Future<dynamic> refreshConditionSearchApiData() async {
    setLoading();
    var conditionSearchBeanEntity =
        await refreshData(mRepository.requestConditionSearch(
      orderBy: orderBy,
      type: selectionConditionModel.param.type,
      classes: selectionConditionModel.param.classes,
      area: selectionConditionModel.param.area,
      year: selectionConditionModel.param.year,
      lang: selectionConditionModel.param.lang,
      letter: selectionConditionModel.param.letter,
      page: "1",
    ));

    if (conditionSearchBeanEntity?.status == 0) {
      currentPage = 1;
      _conditionSearchBeanEntity = conditionSearchBeanEntity;
      selectionConditionModel.setQty(this.qty.toString());
      if (_conditionSearchBeanEntity.qty == 0) {
        setEmpty();
      } else {
        setSuccess();
      }
    }
  }

  Future<dynamic> loadMoreConditionSearchData() async {
    if (isLoadingMore) return;

    //默认每一页36条数据
    if (currentPage >= (qty / 36.toDouble()).ceil()) {
      easyRefreshController.resetLoadState();
      easyRefreshController.finishLoad(noMore: true);
      return;
    }

    isLoadingMore = true;
    var conditionSearchBeanEntity =
        await loadMoreData(mRepository.requestConditionSearch(
      orderBy: orderBy,
      type: selectionConditionModel.param.type,
      classes: selectionConditionModel.param.classes,
      area: selectionConditionModel.param.area,
      year: selectionConditionModel.param.year,
      lang: selectionConditionModel.param.lang,
      letter: selectionConditionModel.param.letter,
      page: (currentPage + 1).toString(),
    ));
    if (conditionSearchBeanEntity != null &&
        conditionSearchBeanEntity.status == 0) {
      _conditionSearchBeanEntity.data.addAll(conditionSearchBeanEntity.data);
      currentPage++;
      easyRefreshController.resetLoadState();
      easyRefreshController.finishLoad(success: true);
    } else {
      easyRefreshController.resetLoadState();
      easyRefreshController.finishLoad(success: false);
    }
    isLoadingMore = false;
  }

  String selectTypeName(SelectConditionCommonBean data, int index) {
    switch (tabType) {
      case IndexPage.TAB_MOVIE:
        return data.movie[index].name;
      case IndexPage.TAB_CARTOON:
        return data.cartoon[index].name;
      case IndexPage.TAB_SHOW:
        return data.show[index].name;
      case IndexPage.TAB_TELEPLAY:
        return data.teleplay[index].name;
        break;
      default:
        return "";
    }
  }

  List<SelectConditionInnerBean> selectList(SelectConditionCommonBean data) {
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
