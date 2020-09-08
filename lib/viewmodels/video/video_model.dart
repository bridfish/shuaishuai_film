import 'package:shuaishuaimovie/models/home_detail_bean_entity.dart';
import 'package:shuaishuaimovie/net/request.dart';
import 'package:shuaishuaimovie/viewmodels/base_model.dart';

class VideoViewModel extends BaseViewModel<MovieRepository> {
  String videoId;
  String videoUrl;
  String playUrlType;
  int playUrlIndex;
  String videoName;
  String videoLevel;
  String currentTime;
  String isPositive;

  VideoViewModel({this.videoId, this.videoUrl, this.playUrlType, this.playUrlIndex, this.videoName, this.videoLevel, this.currentTime, this.isPositive});

  HomeDetailBeanEntity _homeDetailBeanEntity;

  HomeDetailBeanEntity get homeDetailBeanEntity => _homeDetailBeanEntity;

  HomeDetailBeanVod get homeDetailBeanVod => _homeDetailBeanEntity?.vod;

  List<List> get playUrls {
    return homeDetailBeanVod.vodPlayUrls.toJson()[playUrlType];
  }

  String get videoTitle {
    if(homeDetailBeanVod == null) return "";
    final tempPlayUrls =
    (isPositive == "0" ? false : true) ? playUrls.reversed.toList() : playUrls;
    return homeDetailBeanVod.vodName + " " + tempPlayUrls[playUrlIndex][0];
  }

  void changeVideo(int index, bool isPositive) {
    final tempPlayUrls =
    isPositive ? playUrls.reversed.toList() : playUrls;

    playUrlIndex = index;
    videoUrl = tempPlayUrls[index][1];
    videoLevel = tempPlayUrls[index][0];

    notifyListeners();
  }

  Future<dynamic> getHomeDetailApiData(String vodId) async {
    if (!await checkNet()) {
      setNoNetWork();
      return null;
    }
    _homeDetailBeanEntity =
    await requestData(mRepository.requestHomeDetail(vodId));
    if (_homeDetailBeanEntity?.status == 0) {
      setSuccess();
    } else {
      setError(new Error(), message: "请求失败");
    }
  }

  void setPositive(String isPositive) {
    this.isPositive = isPositive;
  }

  @override
  MovieRepository createRepository() {
    return MovieRepository();
  }

}
