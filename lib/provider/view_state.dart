/// 状态枚举类
enum ViewState {
  /// 加载中
  loading,

  /// 数据返回成功
  success,

  /// 空数据
  empty,

  /// 数据返回失败
  error,

  ///no net
  noNetwork,
}

class ViewStateError {
  Error error;
  String message;

  ViewStateError({this.error, this.message}) {
    this.message ??= '服务器异常';
  }
}
