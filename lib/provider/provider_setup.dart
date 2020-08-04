import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:shuaishuaimovie/viewmodels/app_theme_model.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
];

List<SingleChildWidget> independentServices = [
  ChangeNotifierProvider(create: (_) => AppTheme()),
];

List<SingleChildWidget> dependentServices = [
  //这里使用ProxyProvider来定义需要依赖其他Provider的服务
];