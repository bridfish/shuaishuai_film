class RequestConstApi{
  static const SERVICE_API = 'https://vip.88-spa.com:8443/v1/';
  static const HOME_API = SERVICE_API + "home-list";
  static const HOME_DETAIL_API = SERVICE_API + "vod-details";
  static const HOT_UPDATE_API = SERVICE_API + "map";
  static const RANK_WEEK_API = SERVICE_API + "rank-list?cate=vod_hits_week";
  static const RANK_MONTH_API = SERVICE_API + "rank-list?cate=vod_hits_month";
  static const RANK_TOTAL_API = SERVICE_API + "rank-list?cate=vod_hits";
  static const MOVIE_API = SERVICE_API + "list-by-type?type=1";
  static const TELEPLAY_API = SERVICE_API + "list-by-type?type=2";
  static const SHOW_API = SERVICE_API + "list-by-type?type=3";
  static const CARTOON_API = SERVICE_API + "list-by-type?type=4";
  static const SELECT_CONDITION_API = SERVICE_API + "vod-list-options";
  static const CONDITION_SEARCH_API = SERVICE_API + "vod-list?";
  static const TXT_AUTO_SEARCH_API = SERVICE_API + "auto-search?";
  static const TXT_NORMAL_SEARCH_API = SERVICE_API + "search?";
}