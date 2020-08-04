import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/net/base_repository.dart';
import 'package:shuaishuaimovie/utils/net/net_work.dart' as net;

import '../provider/view_state.dart';

/// 父类ViewModel
abstract class BaseViewModel<T extends BaseRepository> with ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool disposed = false;

  /// 初始化状态为加载中
  ViewState _state = ViewState.loading;

  ViewState get state => _state;

  /// 错误状态类
  ViewStateError _viewStateError;

  ViewStateError get viewStateError => _viewStateError;

  T mRepository;

  BaseViewModel({ViewState state}) {
    this._state = state ?? ViewState.loading;
    mRepository = createRepository();
  }

  /// 通用请求数据方法 子类可以复写
  Future<dynamic> requestData(dynamic f) async {
    var result;
    try {
      setLoading();
      result = await f;
      if(result == null) setError(Error());
    } catch (e) {
      setError(Error(), message: "请求失败");
      throw Exception(e);
    }
    return result;
  }

  Future<dynamic> requestNoStatusData(dynamic f) async {
    var result;
    try {
      result = await f;
    } catch (e) {
      throw Exception(e);
    }
    return result;
  }

  Future<dynamic> checkNet() async {
    return await net.isConnected();
  }

  /// 提供一个创建Repository对象的抽象方法T createRepository();
  T createRepository() {
  }

  @override
  void notifyListeners() {
    if (!disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  /// 初始化状态
  void setLoading() {
    debugPrint("build_${this.toString()}_loading");
    setState(ViewState.loading);
  }

  /// 数据成功不为空
  void setSuccess() {
    debugPrint("build_${this.toString()}_success");
    setState(ViewState.success);
  }

  /// 数据成功且为空
  void setEmpty() {
    debugPrint("build_${this.toString()}_empty");
    setState(ViewState.empty);
  }

  /// 数据异常
  void setError(e, {String message}) {
    debugPrint("build_${this.toString()}_error");
    if (e is DioError) {
      e = e.error;
      message = e.message;
    }
    _viewStateError = new ViewStateError(error: e, message: message);
    setState(ViewState.error);
  }

  ///没有网络
  void setNoNetWork() {
    debugPrint("build_${this.toString()}_noNetwork");
    setState(ViewState.noNetwork);
  }

  /// 设置状态改变
  void setState(ViewState state) {
    this._state = state;
    notifyListeners();
  }

  /// 加载中状态
  bool isLoading() {
    return this._state == ViewState.loading;
  }

  /// 数据为空状态
  bool isEmpty() {
    return this._state == ViewState.empty;
  }

  /// 数据异常状态
  bool isError() {
    return this._state == ViewState.error;
  }

  /// 数据加载成功状态 不为空
  bool isSuccess() {
    return this._state == ViewState.success;
  }

  bool isNoNetWork() {
    return this._state == ViewState.noNetwork;
  }

  /// 是否是成功显示数据状态
  /// false 表示数据状态为加载中 数据为空 或者数据加载失败
  /// true 数据成功 or 刷新状态 or 加载更多状态
  bool isSuccessShowDataState() {
    return isSuccess();
  }
}
