import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/database/sqf_provider.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/sharepreference/share_preference.dart';
import 'package:shuaishuaimovie/shuai_movie.dart';
import 'package:shuaishuaimovie/ui/pages/video/video_page.dart';
import 'package:shuaishuaimovie/utils/net/net_work.dart';
import 'package:shuaishuaimovie/video/custom_video_panel.dart';
import 'package:shuaishuaimovie/viewmodels/video/video_model.dart';
import 'package:shuaishuaimovie/widgets/custom_chewie_overlay_widget.dart';
import 'package:shuaishuaimovie/database/bean/video_history_bean.dart'
    as videoHistory;

class ShuaiVideo extends StatefulWidget {
  ShuaiVideo(this.model);

  VideoViewModel model;

  @override
  State<StatefulWidget> createState() {
    return _ShuaiVideoState();
  }
}

class _ShuaiVideoState extends State<ShuaiVideo> {
  FijkPlayer _fijkPlayer;

  StreamSubscription _streamSubscription;
  StreamSubscription _posUpdateSubscription;

  int _lastInMilliseconds = 0;
  int _totalInMilliseconds;
  bool _isAllowMobilePlay = false;
  ValueNotifier<bool> _offStageNotifier = ValueNotifier(true);
  String videoUrl;


  @override
  void initState() {
    super.initState();
    videoUrl = widget.model.videoUrl.replaceFirst(VideoPage.BASE_VIDEO_URL, "");

    if (widget.model.currentTime?.isNotEmpty ?? false)
      _lastInMilliseconds = int.parse(widget.model.currentTime);

    _streamSubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile) {
        _startPlayer(wifiStatus: false);
      } else if (result == ConnectivityResult.wifi) {
        _startPlayer(wifiStatus: true);
      }
    });
  }

  Future _startPlayer({bool wifiStatus = false}) async {
    var autoPlay = false;
    //我的页面在wifi的情况下也可以进行控制设置
    if (wifiStatus) autoPlay = await MovieSharePreference.getAutoPlayValue();

    if (_fijkPlayer == null) {
      _fijkPlayer = FijkPlayer();

      _fijkPlayer.addListener(_addVideoListener);

      //设置视频资源
      await _fijkPlayer.setDataSource(videoUrl,
          autoPlay: autoPlay, showCover: true);

      _posUpdateSubscription =  _fijkPlayer.onCurrentPosUpdate.listen((event) {
        _totalInMilliseconds = _fijkPlayer.value.duration?.inMilliseconds;
        final currentMilliseconds = event.inMilliseconds;
        if (currentMilliseconds > _lastInMilliseconds) {
          _lastInMilliseconds = currentMilliseconds;
        }
      });

      setState(() {});
    } else {
      if (!_isAllowMobilePlay) _playOrPause();
    }

    //非wifi情况下必须暂停播放, 提示用户信息
    if (!_isAllowMobilePlay &&
        !wifiStatus &&
        _offStageNotifier.value != autoPlay) _offStageNotifier.value = autoPlay;
  }

  void _addVideoListener() {
    if (_fijkPlayer.state == FijkState.prepared) {
      _fijkPlayer.seekTo(_lastInMilliseconds ?? 0);
    }
  }

  void _playOrPause() {
    if (_fijkPlayer.isPlayable() ||
        _fijkPlayer.state == FijkState.asyncPreparing) {
      if (_fijkPlayer.state == FijkState.started) {
        _fijkPlayer.pause();
      } else {
        _fijkPlayer.start();
      }
    }
  }

  void _resetFijkPlayer() {
    _destoryFijkPlayer();
    _isAllowMobilePlay = false;
    _lastInMilliseconds = 0;
    _totalInMilliseconds = null;
    _offStageNotifier.value = true;
  }

  void _destoryFijkPlayer() {
    _posUpdateSubscription?.cancel();
    _posUpdateSubscription = null;
    _fijkPlayer?.removeListener(_addVideoListener);
    _fijkPlayer?.release();
    _fijkPlayer = null;
  }

  void _allowUnWifiEnvironmentPlay() {
    _isAllowMobilePlay = true;
    _playOrPause();
  }

  @override
  void dispose() {
    _destoryFijkPlayer();
    _offStageNotifier.dispose();
    _streamSubscription.cancel();
    super.dispose();
  }

  void _storePlay() async {
    if (_totalInMilliseconds == null) return;
    print("store");
    await SqfProvider.db.transaction((txn) async {
      final videoData = await txn.query(videoHistory.tableName,
          where: '${videoHistory.columnVideoId}=?',
          whereArgs: [widget.model.videoId]);
      videoHistory.VideoHistoryBean videoHistoryBean =
          videoHistory.VideoHistoryBean();
      videoHistoryBean
        ..milliseconds = DateTime.now().millisecondsSinceEpoch
        ..totalPlayTime = _totalInMilliseconds
        ..currentPlayTime = _lastInMilliseconds
        ..updateInfo = widget.model.homeDetailBeanVod.vodRemarks
        ..videoName = widget.model.homeDetailBeanVod.vodName
        ..videoId = int.parse(widget.model.videoId)
        ..picUrl = widget.model.homeDetailBeanVod.vodPic
        ..videoLevel = widget.model.videoLevel
        ..playUrlType = widget.model.playUrlType
        ..videoUrl = videoUrl
        ..isPositive = widget.model.isPositive
        ..playUrlIndex = int.parse(widget.model.playUrlIndex);

      if (videoData != null && videoData.length > 0) {
        await txn.update(videoHistory.tableName, videoHistoryBean.toMap(),
            where: '${videoHistory.columnVideoId}=?',
            whereArgs: [widget.model.videoId]);
      } else {
        await txn.insert(videoHistory.tableName, videoHistoryBean.toMap());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Stack(
        children: <Widget>[
          _fijkPlayer == null
              ? Container(
                  color: AppColor.black,
                )
              : FijkView(
                  player: _fijkPlayer,
                  fit: FijkFit.ar16_9,
                  fsFit: FijkFit.ar16_9,
                  color: AppColor.black,
                  panelBuilder: fijkCustomerPanelBuilder(
                      snapShot: true,
                      title: widget.model.videoTitle,
                      onBack: () {
                        Application.router.pop(context);
                      }),
                  onDispose: (fijkData) {
                    //进行数据的保存
                    _storePlay();
                  },
                ),
          ValueListenableBuilder(
            valueListenable: _offStageNotifier,
            builder: (BuildContext context, bool value, Widget child) {
              return Offstage(
                offstage: value,
                child: CustomChewieOverlayWidget(
                  tapMsg: "继续播放",
                  tipsMsg: "当前非wifi环境,是否继续播放",
                  onTap: () {
                    _allowUnWifiEnvironmentPlay();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void didUpdateWidget(ShuaiVideo oldWidget) {
    super.didUpdateWidget(oldWidget);
    var newVideoUrl =
        widget.model.videoUrl.replaceFirst(VideoPage.BASE_VIDEO_URL, "");
    if (videoUrl != newVideoUrl) {
      videoUrl = newVideoUrl;

      _resetFijkPlayer();
      checkNetWifi().then((value) => _startPlayer(wifiStatus: value));
    }
  }
}
