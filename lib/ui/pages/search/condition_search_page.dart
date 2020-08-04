import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shuaishuaimovie/models/select_condition_bean_entity.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/ui/helper/search_list_helper.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/ui/pages/search/tab/hot_search_page.dart';
import 'package:shuaishuaimovie/ui/pages/search/tab/new_search_page.dart';
import 'package:shuaishuaimovie/ui/pages/search/tab/score_search_page.dart';
import 'package:shuaishuaimovie/viewmodels/search/select_condition_model.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class ConditionSearchPage extends StatefulWidget {
  ConditionSearchPage(this.tabType, {this.classes});

  String tabType;
  String classes;

  static const CLASS_TYPE = "class";
  static const YEAR_TYPE = "year";
  static const LANG_TYPE = "lang";
  static const LETTER_TYPE = "letter";
  static const AREA_TYPE = "area";

  @override
  _ConditionSearchPageState createState() => _ConditionSearchPageState();
}

class _ConditionSearchPageState extends State<ConditionSearchPage>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  List tabs = ["按最新", "按最热", "按评分"];
  TabController _tabController;

  final GlobalKey<NewSearchPageState> newConditionKey = GlobalKey();
  final GlobalKey<HotSearchPageState> hotConditionKey = GlobalKey();
  final GlobalKey<ScoreSearchPageState> scoreConditionKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animation = Tween<double>(begin: 0, end: 2).animate(_controller);
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build_condition_search_page");
    return Scaffold(
      backgroundColor: AppColor.black,
      body: SafeArea(
        child: Container(
          color: AppColor.white,
          child: ProviderWidget<SelectionConditionModel>(
            initData: (selectionConditionModel) async {
              await loadSelectionConditionData(selectionConditionModel);
            },
            model: SelectionConditionModel(widget.tabType, widget.classes),
            builder: (context, model, child) {
              debugPrint("build_condition_search_provider");
              if (!model.isSuccess()) {
                return CommonViewStateHelper(
                  model: model,
                  onEmptyPressed: () => loadSelectionConditionData(model),
                  onErrorPressed: () => loadSelectionConditionData(model),
                  onNoNetworkPressed: () => loadSelectionConditionData(model),
                );
              }
              return _buildContent(model);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(SelectionConditionModel model) {
    return SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text("帅帅影视"),
            ),
            SliverToBoxAdapter(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: SelectedListWidget(
                            model.selectedList(widget.tabType)),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_controller.isAnimating) return;
                          if (_controller.isCompleted ||
                              _controller.isDismissed) {
                            _controller.reset();
                            _controller.forward();
                            model.resetStatusParam(
                                classIndex: 0,
                                areaIndex: 0,
                                letterIndex: 0,
                                langIndex: 0,
                                yearIndex: 0);
                            refreshChildTab();
                          }
                        },
                        child: Row(
                          children: <Widget>[
                            RotationTransition(
                              turns: _animation,
                              child: Icon(
                                Icons.refresh,
                                size: 15,
                                color: AppColor.icon_yellow,
                              ),
                            ),
                            CommonText(
                              "重置",
                            ),
                            SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  selectConditionList(
                      model,
                      model.getTypeList(model.selectConditionBeanEntity.types),
                      ConditionSearchPage.CLASS_TYPE),
                  selectConditionList(
                      model,
                      model.getTypeList(model.selectConditionBeanEntity.areas),
                      ConditionSearchPage.AREA_TYPE),
                  selectConditionList(
                      model, model.timeList(), ConditionSearchPage.YEAR_TYPE),
                  selectConditionList(
                      model,
                      model.selectConditionBeanEntity.languages,
                      ConditionSearchPage.LANG_TYPE),
                  selectConditionList(model, model.letterList(),
                      ConditionSearchPage.LETTER_TYPE),
                ],
              ),
            ),
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverPersistentHeader(
                delegate: FixSliverHeaderDelegate(tabs, _tabController,
                    context.watch<SelectionConditionModel>().qty),
                pinned: true,
              ),
            ),
          ];
        },
        //避免重复build
        body: Consumer<SelectionConditionModel>(
          builder: (_, __, child) {
            return child;
          },
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              NewSearchPage(
                key: newConditionKey,
                model: model,
                tabType: widget.tabType,
              ),
              HotSearchPage(
                key: hotConditionKey,
                model: model,
                tabType: widget.tabType,
              ),
              ScoreSearchPage(
                key: scoreConditionKey,
                model: model,
                tabType: widget.tabType,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> loadSelectionConditionData(SelectionConditionModel model) async {
    await model.getSelectConditionApiData();
  }

  Widget selectConditionList(SelectionConditionModel model,
      List<SelectConditionInnerBean> list, String type) {
    return list != null && list.length > 0
        ? ConditionSearchList(
            list,
            type,
            onSelected: (index) {
              switch (type) {
                case ConditionSearchPage.AREA_TYPE:
                  if (isLoadingChildTab()) return;
                  model.setSelectedAreaIndexIndex(index);
                  refreshChildTab();
                  break;
                case ConditionSearchPage.LETTER_TYPE:
                  if (isLoadingChildTab()) return;
                  model.setSelectedLetterIndexIndex(index);
                  refreshChildTab();
                  break;
                case ConditionSearchPage.LANG_TYPE:
                  if (isLoadingChildTab()) return;
                  model.setSelectedLangIndex(index);
                  refreshChildTab();
                  break;
                case ConditionSearchPage.CLASS_TYPE:
                  if (isLoadingChildTab()) return;
                  model.setSelectedClassesIndex(index);
                  refreshChildTab();
                  break;
                case ConditionSearchPage.YEAR_TYPE:
                  if (isLoadingChildTab()) return;
                  model.setSelectedYearIndexIndex(index);
                  refreshChildTab();
                  break;
              }
            },
          )
        : SizedBox.shrink();
  }

  void refreshChildTab() {
    switch (_tabController.index) {
      case 0:
        newConditionKey.currentState?.refreshData();
        break;
      case 1:
        hotConditionKey.currentState?.refreshData();
        break;
      case 2:
        scoreConditionKey.currentState?.refreshData();
        break;
    }
  }

  bool isLoadingChildTab() {
    switch (_tabController.index) {
      case 0:
        return newConditionKey.currentState.isLoading();
      case 1:
        return hotConditionKey.currentState.isLoading();
      case 2:
        return scoreConditionKey.currentState.isLoading();
      default:
        return false;
    }
  }
}

class FixSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  FixSliverHeaderDelegate(this.tabs, this._tabController, this.qty);

  String qty;

  List tabs;
  TabController _tabController;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.all(10),
      color: AppColor.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: MediaQuery.of(context).size.width - 130,
            child: TabBar(
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: AppColor.icon_yellow,
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              unselectedLabelColor: AppColor.black,
              controller: _tabController,
              tabs: tabs
                  .map((e) => Tab(
                        text: e,
                      ))
                  .toList(),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: RichText(
              text: TextSpan(
                  text: "共有",
                  style: TextStyle(fontSize: 12, color: AppColor.black),
                  children: [
                    TextSpan(
                        text: qty,
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColor.icon_yellow,
                        )),
                    TextSpan(
                      text: "个频道",
                      style: TextStyle(fontSize: 12, color: AppColor.black),
                    ),
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 67;

  @override
  double get minExtent => 67;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
