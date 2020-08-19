final String tableName = "video_history_table";
final String columnPicUrl = 'pic_url';
final String columnVideoName = 'video_name';
final String columnVideoId = 'video_id';
final String columnCurrentPlayTime = "current_play_time";
final String columnTotalPlayTime = "total_play_time";
final String columnUpdateInfo = "update_info";
final String columnMilliseconds = "milliseconds";
final String columnVideoLevel = "video_level";
final String columnPlayUrlType = "play_url_type";
final String columnPlayUrlIndex = "play_url_index";
final String columnVideoUrl = "video_url";

class VideoHistoryBean {
  String picUrl;
  String videoName;
  String updateInfo;
  String videoLevel;
  String playUrlType;
  String videoUrl;
  int videoId;
  int currentPlayTime;
  int totalPlayTime;
  int milliseconds;
  int playUrlIndex;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnVideoName: videoName,
      columnPicUrl: picUrl,
      columnVideoId: videoId,
      columnCurrentPlayTime: currentPlayTime,
      columnTotalPlayTime: totalPlayTime,
      columnUpdateInfo: updateInfo,
      columnMilliseconds: milliseconds,
      columnPlayUrlIndex: playUrlIndex,
      columnPlayUrlType: playUrlType,
      columnVideoLevel: videoLevel,
      columnVideoUrl: videoUrl,
    };

    return map;
  }
}
