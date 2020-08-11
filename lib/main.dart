import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shuaishuaimovie/database/sqf_provider.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/ui/pages/splash_page.dart';
import 'package:shuaishuaimovie/viewmodels/app_theme_model.dart';
import 'package:shuaishuaimovie/provider/provider_setup.dart';
import 'package:shuaishuaimovie/routes/routes.dart';
import 'package:shuaishuaimovie/shuai_movie.dart';

import 'sharepreference/share_preference.dart';
import 'utils/system/system_chrome.dart';

void main() {
  runApp(MyApp());
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
    _initSharePreference();
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
          home: AnnotatedRegion(
              value: MovieSystemChrome.statusDark, child: SplashPage()),
        ),
      ),
    );
  }

  void _initDB() {
    SqfProvider.initSQF();
  }

  void _initSharePreference() {
    //没有找到设置默认值的地方，所以通过判断返回是空的话设置默认值。
    MovieSharePreference.getAutoPlayValue().then((value) {
      if (value == null) MovieSharePreference.saveAutoPlayValue(true);
    });
  }
}
