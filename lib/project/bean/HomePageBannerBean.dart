/**
    "desc":"享学~",
    "id":29,
    "imagePath":"https://www.wanandroid.com/blogimgs/811863f8-04d7-4695-a49f-c3989a301ec0.jpeg",
    "isVisible":1,
    "order":0,
    "title":"2020年，定个小目标。",
    "type":0,
    "url":"https://mp.weixin.qq.com/s/yipmY0SADmsZCoXvVvrB3w"
 */
//class HomePageOperateBean{
//
//  String id;
//  String desc;
//  String imagePath;
//  bool isVisible;
//  String order;
//  String title;
//  String type;
//  String url;
//
//}


class HomePageBannerBean {
  List<BannerData> data;
  int errorCode;
  String errorMsg;

  HomePageBannerBean({this.data, this.errorCode, this.errorMsg});

  HomePageBannerBean.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<BannerData>();
      json['data'].forEach((v) {
        data.add(new BannerData.fromJson(v));
      });
    }
    errorCode = json['errorCode'];
    errorMsg = json['errorMsg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['errorCode'] = this.errorCode;
    data['errorMsg'] = this.errorMsg;
    return data;
  }
}

class BannerData {
  String desc;
  int id;
  String imagePath;
  int isVisible;
  int order;
  String title;
  int type;
  String url;

  BannerData(
      {this.desc,
        this.id,
        this.imagePath,
        this.isVisible,
        this.order,
        this.title,
        this.type,
        this.url});

  BannerData.fromJson(Map<String, dynamic> json) {
    desc = json['desc'];
    id = json['id'];
    imagePath = json['imagePath'];
    isVisible = json['isVisible'];
    order = json['order'];
    title = json['title'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['desc'] = this.desc;
    data['id'] = this.id;
    data['imagePath'] = this.imagePath;
    data['isVisible'] = this.isVisible;
    data['order'] = this.order;
    data['title'] = this.title;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}