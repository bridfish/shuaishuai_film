import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shuaishuaimovie/database/sqf_provider.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/utils/system/system_chrome.dart';
import 'package:shuaishuaimovie/viewmodels/app_theme_model.dart';
import 'package:shuaishuaimovie/provider/provider_setup.dart';
import 'package:shuaishuaimovie/routes/routes.dart';
import 'package:shuaishuaimovie/shuai_movie.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(MovieSystemChrome.statusDark);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  _MyAppState() {
    final router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    //初始化数据库
    _initDB();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Builder(
        builder: (context) => MaterialApp(
          title: "帅帅影视",
          color: AppColor.black,
          theme: ThemeData(
            accentColor: AppColor.icon_yellow,
            scaffoldBackgroundColor: AppColor.white,
            appBarTheme: AppBarTheme(
              color: AppColor.black,
            ),
            iconTheme: IconThemeData(
              color: context.watch<AppTheme>().iconThemeColor,
            ),
          ),
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Application.router.generator,
        ),
      ),
    );
  }

  void _initDB() {
    SqfProvider.initSQF();
  }
}
