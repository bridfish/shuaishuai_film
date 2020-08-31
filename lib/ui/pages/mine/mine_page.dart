import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/sharepreference/share_preference.dart';
import 'package:shuaishuaimovie/utils/app_info_util.dart';
import 'package:shuaishuaimovie/widgets/text_widget.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  bool isAutoPlay = true;
  String appVersion = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => AppInfoUtil.getAppVersion().then((value) {
              setState(() {
                appVersion = value;
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    print(appVersion);

    return Scaffold(
      appBar: AppBar(
        title: Text("留言页面"),
        centerTitle: true,
        backgroundColor: AppColor.black,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            ListTile(
              title: Text("视频自动播放"),
              trailing: Switch(
                value: isAutoPlay,
                onChanged: (bool value) {
                  setState(() {
                    isAutoPlay = !isAutoPlay;
                    MovieSharePreference.saveAutoPlayValue(isAutoPlay);
                  });
                },
              ),
            ),
            ListTile(
              title: Text("作者微信号："),
              trailing: SelectableText("MS_miaoshuai"),
            ),
            ListTile(
              title: Text("当前版本号："),
              trailing: Text(appVersion),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CommonText(
                    "结束语：",
                    txtSize: 16,
                    txtWeight: FontWeight.bold,
                  ),
                  CommonText(
                    "    Flutter的框架和社区已经算是非常的成熟了，对于Flutter的流行度你可以通过github的star不难看出这个框架不亚于RN等主流的跨平台开发的其他的框架。而且Flutter出道比较晚，当前作者基于开发的版本才1.20。所以作者认为对于Flutter接下来的路还是相当客观的。在这里也不多说Flutter的优点了，如果不知道的小伙伴可以看官网或者搜索一些其他对Flutter的认知的文章进行阅读。",
                    txtSize: 15,
                  ),
                  CommonText(
                    "    作者开发了这个帅帅影视的开源项目的目的在于1.可以在项目中对于flutter进行跟深入的学习。2.同样为了帮助那些想要学习或者正要进行学习Flutter的同学的提供一个开源的Flutter项目用于参考",
                    txtSize: 15,
                  ),
                  CommonText(
                    "    在开发项目中，作者不得不在一次感慨一下开发起来特别爽，开发一款Flutter的项目的开发进度作者认为至少比原生提高百分之20%，更何况一套代码两端运行呢！",
                    txtSize: 15,
                  ),
                  CommonText(
                    "    最后如果小伙伴拥有好的idea，并且可以进行用Flutter开发的话。愿意参与进行共同维护这块开源项目，为Flutter社区做一些贡献的欢迎私聊我哦。",
                    txtSize: 15,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
