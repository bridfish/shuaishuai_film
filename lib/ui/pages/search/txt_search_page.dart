import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/shuai_movie.dart';
import 'package:shuaishuaimovie/ui/pages/search/widget/txt_auto_search_child.dart';
import 'package:shuaishuaimovie/ui/pages/search/widget/txt_history_search_child.dart';
import 'package:shuaishuaimovie/ui/pages/search/widget/txt_normal_search_child.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class TxtSearchPage extends StatefulWidget {
  static const TXT_SEARCH = "txt_search";

  @override
  _TxtSearchPageState createState() => _TxtSearchPageState();
}

class _TxtSearchPageState extends State<TxtSearchPage> {
  ValueNotifier<bool> _offStageValueNotifier;
  int _currentPageIndex = 0;
  TextEditingController _editingController;
  GlobalKey<TxtAutoSearchChildState> _autoSearchKey = GlobalKey();
  GlobalKey<TxtNormalSearchChildState> _normalSearchKey = GlobalKey();
  FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
    _offStageValueNotifier = ValueNotifier<bool>(true);
    _focusNode = FocusNode();

    _editingController.addListener(() {
      //normal_search 处理逻辑
      if (_currentPageIndex == 2) {
        _editingController.text = "";
        if (!_offStageValueNotifier.value) _offStageValueNotifier.value = true;
        return;
      }

      final value = _editingController.text;

      if (value.isEmpty) {
        setState(() {
          _currentPageIndex = 0;
          if (!_offStageValueNotifier.value) _offStageValueNotifier.value = true;
          _autoSearchKey.currentState.resetData();
          _normalSearchKey.currentState.resetData();
        });
      } else {
        if (_offStageValueNotifier.value) _offStageValueNotifier.value = false;
        setState(() {
          _currentPageIndex = 1;
        });
        _autoSearchKey.currentState.loadData(value).whenComplete(() {
          if (_currentPageIndex != 1) {
            _autoSearchKey.currentState.resetData();
          }
        });
      }
    });

    //延时获取焦点，将动画执行完
    Future.delayed(Duration(milliseconds: 500), () {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _editingController.dispose();
    _offStageValueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            closeCurrentPage();
          },
          child: Hero(
            tag: TxtSearchPage.TXT_SEARCH,
            child: Icon(
              Icons.arrow_back,
              color: AppColor.white,
            ),
            transitionOnUserGestures: true,
          ),
        ),
        title: GestureDetector(
          onTap: _currentPageIndex == 2
              ? () {
                  setState(() {
                    _currentPageIndex = 0;
                  });
                }
              : null,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColor.lightGrey,
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _editingController,
                    autofocus: false,
                    enabled: _currentPageIndex != 2,
                    focusNode: _focusNode,
                    cursorColor: AppColor.black,
                    style: TextStyle(
                      color: AppColor.black,
                      fontSize: 14,
                    ),
                    textInputAction: TextInputAction.search,
                    onEditingComplete: () {
                      if (_editingController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "你输入搜索内容");
                        return;
                      }
                      switchNormalSearchPage(_editingController.text);
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      border: UnderlineInputBorder(borderSide: BorderSide.none),
                      hintText: "海量影片等你来搜索",
                      hintStyle: TextStyle(
                        color: AppColor.grey,
                        fontSize: 14,
                        textBaseline: TextBaseline.alphabetic,
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: _offStageValueNotifier,
                  builder: (BuildContext context, bool value, Widget child) {
                    print(value);
                    return Offstage(
                      offstage: _offStageValueNotifier.value,
                      child: child,
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      _editingController.text = "";
                    },
                    child: Container(
                      width: 17,
                      height: 17,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColor.black,
                      ),
                      child: Icon(
                        Icons.clear,
                        size: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              final index = _currentPageIndex;
              if (index == 1) {
                _editingController.text = "";
                if (_focusNode.hasFocus) _focusNode.unfocus();
              } else if (index == 2) {
                setState(() {
                  _currentPageIndex = 0;
                });
              } else {
                closeCurrentPage();
              }
            },
            child: Container(
                padding: EdgeInsets.only(right: 10),
                alignment: Alignment.center,
                child: CommonText(
                  "取消",
                  txtColor: AppColor.white,
                  txtSize: 15,
                )),
          ),
        ],
      ),
      body: IndexedStack(
        index: _currentPageIndex,
        children: <Widget>[
          TxtHistorySearchChild(
            onHistoryTxtTap: (value) {
              switchNormalSearchPage(value);
            },
          ),
          TxtAutoSearchChild(
            key: _autoSearchKey,
            jumpCallback: () {
              _editingController.text = "";
              _focusNode.unfocus();
            },
          ),
          TxtNormalSearchChild(
            key: _normalSearchKey,
            jumpCallback: () {},
          ),
        ],
      ),
    );
  }

  void switchNormalSearchPage(String keyword) {
    setState(() {
      _currentPageIndex = 2;
      _normalSearchKey.currentState.loadData(keyword);
      _focusNode.unfocus();
    });

  }

  void closeCurrentPage() {
    if (_focusNode.hasFocus) _focusNode.unfocus();
    Application.router.pop(context);
  }
}
