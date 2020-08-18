import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shuaishuaimovie/database/sqf_provider.dart';
import 'package:shuaishuaimovie/res/app_color.dart';
import 'package:shuaishuaimovie/sharepreference/share_preference.dart';
import 'package:shuaishuaimovie/ui/pages/video/video_page.dart';
import 'package:shuaishuaimovie/utils/net/net_work.dart';
import 'package:shuaishuaimovie/viewmodels/video/video_model.dart';
import 'package:shuaishuaimovie/widgets/custom_chewie_overlay_widget.dart';
import 'package:shuaishuaimovie/widgets/custom_controls.dart';
import 'package:video_player/video_player.dart';
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
  StreamSubscription _streamSubscription;
  VideoPlayerController _videoPlayerController;
  ChewieController _chewieController;

  int _lastInMilliseconds = 0;
  int _totalInMilliseconds;
  bool _isAllowMobilePlay = false;
  ValueNotifier<bool> _offStageNotifier;
  String videoUrl;

  @override
  void initState() {
    super.initState();

    if (widget.model.currentTime?.isNotEmpty ?? false)
      _lastInMilliseconds = int.parse(widget.model.currentTime);

    videoUrl = widget.model.videoUrl.replaceFirst(VideoPage.BASE_VIDEO_URL, "");

    _offStageNotifier = ValueNotifier(true);

    checkNetMobile().then((value) {
      return value == false
          ? MovieSharePreference.getAutoPlayValue()
          : Future.value(false);
    }).then((value) {
      _initVideo(isAutoPlay: value);
      _streamSubscription = Connectivity()
          .onConnectivityChanged
          .listen((ConnectivityResult result) {
        if (result == ConnectivityResult.mobile) {
          _unWifiEnvironment();
        } else if (result == ConnectivityResult.wifi) {
          _wifiEnvironment();
        }
      });
    });
  }

  Future _initVideo({bool isAutoPlay = true}) async {
    final videoPlayerController = VideoPlayerController.network(videoUrl);
    final old = _videoPlayerController;
    _videoPlayerController = videoPlayerController;
    if (old != null) {
      old.removeListener(_playerPositionListener);
      await old.pause();
    }

    setState(() {
      _initChewie(isAutoPlay: isAutoPlay);
      _videoPlayerController.addListener(_playerPositionListener);
    });
  }

  void _initChewie({bool isAutoPlay = true}) {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: isAutoPlay,
      looping: false,
      showControls: true,
      allowedScreenSleep: false,
      startAt: Duration(milliseconds: _lastInMilliseconds),
      customControls: CustomControls(
          title: widget.model.videoName + " " + widget.model.videoLevel),
      materialProgressColors: ChewieProgressColors(
        playedColor: AppColor.icon_yellow,
        handleColor: AppColor.icon_yellow,
        backgroundColor: Colors.grey,
        bufferedColor: AppColor.icon_yellow.withOpacity(.5),
      ),
      placeholder: Container(
        color: Colors.black,
      ),
      errorBuilder: (context, error) {
        return CustomChewieOverlayWidget(
          onTap: () {
            setState(() {
              _initVideo();
            });
          },
          tapMsg: "点击重试",
          tipsMsg: "视频加载失败， 请稍后再试",
        );
      },
      autoInitialize: true,
    );
  }

  void _resetChewiePlayer() {
    _isAllowMobilePlay = false;
    _lastInMilliseconds = 0;
    _totalInMilliseconds = null;
    _offStageNotifier.value = true;
  }

  void _wifiEnvironment() {
    if (!_videoPlayerController.value.isPlaying && !_offStageNotifier.value) {
      _chewieController.play();
      _offStageNotifier.value = true;
    }
  }

  void _unWifiEnvironment() {
    if (_isAllowMobilePlay) return;
    _chewieController.pause();
    _offStageNotifier.value = false;
  }

  void _allowUnWifiEnvironmentPlay() {
    _wifiEnvironment();
    _isAllowMobilePlay = true;
  }

  Future _playerPositionListener() async {
    //总进度保存
    if (_totalInMilliseconds == null) {
      _totalInMilliseconds =
          _videoPlayerController.value.duration?.inMilliseconds;
    }
    final position = await _videoPlayerController.position;
    if (position.inMicroseconds > _lastInMilliseconds) {
      _lastInMilliseconds = position.inMilliseconds;
    }
  }

  @override
  void dispose() {
    //进行数据的保存
    _storePlay();
    _videoPlayerController.dispose();
    _offStageNotifier.dispose();
    _streamSubscription.cancel();
    super.dispose();
  }

  void _storePlay() async {
    if (_totalInMilliseconds == null ||
        !_videoPlayerController.value.initialized) return;
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
          if (_chewieController != null && _videoPlayerController != null)
            Chewie(
              controller: _chewieController,
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
      _resetChewiePlayer();
      MovieSharePreference.getAutoPlayValue()
          .then((value) => _initVideo(isAutoPlay: value));
    }
  }
}
