import 'package:shuaishuaimovie/models/common_item_bean_entity.dart';
import 'package:shuaishuaimovie/models/txt_auto_search_bean_entity.dart';

txtAutoSearchBeanEntityFromJson(TxtAutoSearchBeanEntity data, Map<String, dynamic> json) {
  if (json['data'] != null) {
    data.data = new List<CommonItemBean>();
    (json['data'] as List).forEach((v) {
      data.data.add(new CommonItemBean().fromJson(v));
    });
  }

  if (json['status'] != null) {
    data.status = json['status']?.toInt();
  }

  return data;
}

Map<String, dynamic> txtAutoSearchBeanEntityToJson(TxtAutoSearchBeanEntity entity) {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  if (entity.data != null) {
    data['data'] =  entity.data.map((v) => v.toJson()).toList();
  }

  data['status'] = entity.status;

  return data;
}