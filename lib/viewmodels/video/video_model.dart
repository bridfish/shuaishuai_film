import 'package:shuaishuaimovie/models/home_detail_bean_entity.dart';
import 'package:shuaishuaimovie/net/request.dart';
import 'package:shuaishuaimovie/viewmodels/base_model.dart';

class VideoViewModel extends BaseViewModel<MovieRepository> {
  String videoId;
  String videoUrl;
  String playUrlType;
  String playUrlIndex;
  String videoName;
  String videoLevel;

  VideoViewModel({this.videoId, this.videoUrl, this.playUrlType, this.playUrlIndex, this.videoName, this.videoLevel});

  HomeDetailBeanEntity _homeDetailBeanEntity;

  HomeDetailBeanEntity get homeDetailBeanEntity => _homeDetailBeanEntity;

  HomeDetailBeanVod get homeDetailBeanVod => _homeDetailBeanEntity?.vod;

  List<List> get playUrls {
    return homeDetailBeanVod.vodPlayUrls.toJson()[playUrlType];
  }

  String get videoTitle {
    if(homeDetailBeanVod == null) return "";
    return homeDetailBeanVod.vodName + " " + playUrls[int.parse(playUrlIndex)][0];
  }

  void changeVideo(int index) {
    playUrlIndex = index.toString();
    videoUrl = playUrls[index][1];
    videoLevel = playUrls[index][0];
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

  @override
  MovieRepository createRepository() {
    return MovieRepository();
  }

}
