import 'package:dio/dio.dart';
import 'request_const.dart';

class HttpHelper {
  Dio _dio;

  factory HttpHelper() => _getProvider();

  HttpHelper._internal();

  static HttpHelper get instance => _getProvider();
  static HttpHelper _httpHelper;

  static HttpHelper _getProvider() {
    if (_httpHelper == null) {
      _httpHelper = new HttpHelper._internal();
    }
    return _httpHelper;
  }

  ///创建dio网络请求对象
  Dio _createDio() {
    final options = BaseOptions(
        baseUrl: RequestConstApi.SERVICE_API,
        connectTimeout: 30 * 1000,
        receiveTimeout: 30 * 1000);
    final dio = new Dio(options);
    // 添加通用拦截器
//    for (Interceptor interceptor in getInterceptors()) {
//      dio.interceptors.add(interceptor);
//    }
    return dio;
  }

  // 子类可以复写该方法 自定义添加拦截器
  List<Interceptor> getInterceptors() {

  }

  Dio getDio() {
    if (_dio == null) {
      _dio = _createDio();
    }
    return _dio;
  }
}
