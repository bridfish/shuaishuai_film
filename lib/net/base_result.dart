/// 通用返回类
class BaseResult {
  /// 返回数据bean
  dynamic data;
  /// 状态码
  int code;
  /// 返回信息
  String message;
  BaseResult({this.data, this.code, this.message});
}
