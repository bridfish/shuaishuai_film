import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shuaishuaimovie/provider/view_state.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/viewmodels/base_model.dart';

/// 针对加载中 数据为空 数据加载失败做统一处理
class CommonViewStateHelper<T extends BaseViewModel> extends StatelessWidget {
  final T model;
  final VoidCallback onEmptyPressed;
  final VoidCallback onErrorPressed;
  final VoidCallback onNoNetworkPressed;

  CommonViewStateHelper({
    @required this.model,
    this.onEmptyPressed,
    this.onErrorPressed,
    this.onNoNetworkPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (model.isLoading()) {
      return new ViewStateLoadingWidget();
    } else if (model.isEmpty()) {
      return new ViewStateEmptyWidget(onPressed: onEmptyPressed);
    } else if(model.isNoNetWork()) {
     Fluttertoast.showToast(msg: "当前没有网络");
      return new ViewStateNoNetworkWidget(onPressed: onNoNetworkPressed);
    } else if (model.isError()) {
      Fluttertoast.showToast(msg: "请求失败");
      return new ViewStateErrorWidget(
          error: model.viewStateError, onPressed: onErrorPressed);
    } else {
      throw new Exception('状态异常，请核查状态');
    }
  }
}

/// 初始化 加载中
class ViewStateLoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: AppColor.white,
      body: new Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

/// 页面无数据
class ViewStateEmptyWidget extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  ViewStateEmptyWidget({this.message, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                message ?? '暂无数据,点击重试',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColor.black_33),
              ),
            ),
          )),
    );
  }
}

/// 页面数据请求异常
class ViewStateErrorWidget extends StatelessWidget {
  final ViewStateError error;
  final VoidCallback onPressed;

  ViewStateErrorWidget({this.error, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                '数据请求异常,点击重试',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColor.black_33),
              ),
            ),
          )),
    );
  }
}

/// 页面没有网络
class ViewStateNoNetworkWidget extends StatelessWidget {
  final String message;
  final VoidCallback onPressed;

  ViewStateNoNetworkWidget({this.message, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
          onTap: () {
            onPressed();
          },
          child: Center(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Text(
                message ?? '没有网络,点击重试',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: AppColor.black_33),
              ),
            ),
          )),
    );
  }
}
