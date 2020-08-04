import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/provider/provider_widget.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/ui/helper/video_history_list_helper.dart';
import 'package:shuaishuaimovie/ui/helper/view_state_helper.dart';
import 'package:shuaishuaimovie/viewmodels/history/video_history_model.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class VideoHistoryPage extends StatefulWidget {
  @override
  _VideoHistoryPageState createState() => _VideoHistoryPageState();
}

class _VideoHistoryPageState extends State<VideoHistoryPage>
    with SingleTickerProviderStateMixin {
  ValueNotifier<bool> _editNotifier;
  ValueNotifier<int> _delNotifier;
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _editNotifier = ValueNotifier(false);
    _delNotifier = ValueNotifier(0);
    _animationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    _animation = Tween<double>(begin: 0, end: 40).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    _editNotifier.dispose();
    _delNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<VideoHistoryModel>(
      initData: (model) {
        model.readLocalVideoHistoryData();
      },
      model: VideoHistoryModel(),
      builder: (_, VideoHistoryModel model, Widget child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("搜索历史"),
            centerTitle: true,
            backgroundColor: AppColor.black,
            actions: <Widget>[
              if (model.isSuccess() && model.isNotEmptyData())
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _operateEdit(model);
                  },
                  child: Container(
                      margin: EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: ValueListenableBuilder(
                        valueListenable: _editNotifier,
                        builder:
                            (BuildContext context, bool value, Widget child) {
                          return CommonText(
                            value ? "取消" : "编辑",
                            txtColor: AppColor.white,
                          );
                        },
                      )),
                ),
            ],
          ),
          body: _buildContent(model),
        );
      },
    );
  }

  Widget _buildContent(VideoHistoryModel model) {
    return Stack(
      children: <Widget>[
        model.isSuccess()
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    //今天的历史数据
                    if (model.todayVideoHistoryList.length > 0)
                      StickyHeaderList(
                        title: "今天",
                        sliver: VideoHistoryList(
                          model: model,
                          animation: _animation,
                          list: model.todayVideoHistoryList,
                          startIndex: 0,
                          onCheckTap: () {
                            _updateDelWidget(model);
                          },
                        ),
                      ),

                    //昨天的历史数据
                    if (model.yesterdayVideoHistoryList.length > 0)
                      StickyHeaderList(
                        title: "昨天",
                        sliver: VideoHistoryList(
                          model: model,
                          animation: _animation,
                          list: model.yesterdayVideoHistoryList,
                          startIndex: model.todayVideoHistoryList.length,
                          onCheckTap: () {
                            _updateDelWidget(model);
                          },
                        ),
                      ),

                    //更多天的历史数据
                    if (model.moreDayVideoHistoryList.length > 0)
                      StickyHeaderList(
                        title: "更多",
                        sliver: VideoHistoryList(
                          model: model,
                          animation: _animation,
                          list: model.moreDayVideoHistoryList,
                          startIndex: model.todayVideoHistoryList.length +
                              model.yesterdayVideoHistoryList.length,
                          onCheckTap: () {
                            _updateDelWidget(model);
                          },
                        ),
                      ),

                    //占位，防止删除的组件出来之后将list遮挡住
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 40,
                      ),
                    ),
                  ],
                ),
              )
            : CommonViewStateHelper(
                model: model,
              ),

        //过滤组件
        Positioned(
          right: 0,
          top: 20,
          child: Row(
            children: <Widget>[
              CommonText(model.isFilter ? "过滤已看完的" : "全部历史"),
              Switch(
                value: model.isFilter,
                onChanged: (bool value) {
                  model.onFilterTap();
                },
              ),
            ],
          ),
        ),
        //删除的组件
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, __) {
              return Container(
                height: _animation.value,
                width: double.infinity,
                color: AppColor.lightGrey,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          model.operateAllCheckData();
                          _updateDelWidget(model);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: CommonText(model.isAllChecked ? "取消全选" : "全选"),
                        ),
                      ),
                    ),
                    Container(
                      width: .5,
                      margin: EdgeInsets.symmetric(vertical: 10),
                      color: AppColor.black,
                    ),
                    Expanded(
                      child: ValueListenableBuilder(
                        valueListenable: _delNotifier,
                        builder:
                            (BuildContext context, int value, Widget child) {
                          return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: value > 0
                                ? () {
                                    model.delCheckedData();
                                    _operateEdit(model);
                                  }
                                : null,
                            child: Container(
                              foregroundDecoration: BoxDecoration(
                                color: value == 0
                                    ? AppColor.lightGrey.withOpacity(.5)
                                    : AppColor.transparent,
                              ),
                              alignment: Alignment.center,
                              child: CommonText(
                                value == 0 ? "删除" : "删除($value)",
                                txtColor: AppColor.red,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  //更新删除组件
  void _updateDelWidget(model) {
    if (_delNotifier.value != model.checkedMap.length) {
      _delNotifier.value = model.checkedMap.length;
    }
  }

  void _operateEdit(model) {
    //如果正在执行动画，禁止点击
    if (_animationController.isAnimating) return;
    model.onEditTap();
    _updateDelWidget(model);

    if (model.isEdit) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    _editNotifier.value = model.isEdit;
  }
}
