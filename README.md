# shuaishuai_movie
基于Provider+MVVM的Flutter 视频App项目,帅帅影视是一个含有海量视频的app，各种视频随你来看。

# 先来点样图

| ![home.gif](https://i.loli.net/2020/08/04/HwRLQZq7FVyntOd.gif) | ![detail_page.gif](https://i.loli.net/2020/08/04/v4M9zTgKVmwDB6q.gif) | ![play_video.gif](https://i.loli.net/2020/08/04/ZmKUgGxMPIu8vRc.gif)| 
| --- | --- | --- |
|![selection_search.gif](https://i.loli.net/2020/08/04/GtEiqpxmU8YyNwn.gif)| ![drop_style.gif](https://i.loli.net/2020/08/04/ymt2baxMTkEerij.gif) | ![text_search.gif](https://i.loli.net/2020/08/04/m7tp85ijWVJTAwf.gif)|
| ![history.gif](https://i.loli.net/2020/08/04/CNueqV4O23ZxKJU.gif) | | 


**主要使用到的一些三方库:**

|**第三方库**	   |**功能**  |**github地址**  |
|  ----  | ----  |----  |
| dio  | 网络请求 | https://github.com/flutterchina/dio|
| video_player  | 视频播放 |https://github.com/flutter/plugins/tree/master/packages/video_player|
| chewie  | 视频播放 | https://github:com/brianegan/chewie |
|  fluro  | 路由跳转 | https://github.com/theyakka/fluro |
|  connectivity  | 网络变化监听 | https://pub.dev/packages/connectivity |
|  flutter_easyrefresh  | 上拉加载下拉刷新 | https://github.com/xuelongqy/flutter_easyrefresh |
|  flutter_sticky_header  | 粘性头部 | https://github.com/letsar/flutter_sticky_header |
|  cached_network_image  | 图片缓存 | https://github.com/Baseflow/flutter_cached_network_image |
|  fluttertoast  | 吐司 | https://github.com/ponnamkarthik/FlutterToast |
|  shared_preferences  | shared存储 | https://pub.dev/packages?q=shared_preferences |

# 更新

## V1.1.0 `2020-09-08` 
- 修复视频快速切换bug
- 视频播放器添加手势滑动调整音量和亮度
- 修改文字搜索历史逻辑
- 修改部分icon图标

## V1.0.0 `2020-08-19` 
- 添加留言模块
- 添加历史记录可以点击继续观看功能
- 添加控制视频是否自动播放功能
- 添加启动页闪屏动画功能

## V0.0.1 `2020-08-04` 
- 帅帅影视的基本功能已完成
