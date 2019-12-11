import 'package:flutter_mm/project/bean/HomePageArticleBean.dart';
import 'package:flutter_mm/project/bean/HomePageBannerBean.dart';
import 'package:flutter_mm/project/bean/HotKeyBean.dart';
import 'package:flutter_mm/project/bean/PubSubArticleListBean.dart';
import 'package:flutter_mm/project/bean/PubSubscriptionBean.dart';
import 'package:flutter_mm/project/bean/ResponseBean.dart';
import 'package:flutter_mm/project/bean/StudyTreeBean.dart';
import 'package:flutter_mm/project/bean/UserBean.dart';
import 'package:flutter_mm/project/model/HttpConstants.dart';
import 'package:flutter_mm/project/util/SharedPreferencesUtil.dart';
import 'package:flutter_mm/project/util/UserData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//import 'package:wanandroid/constants.dart';
//import 'package:wanandroid/model/home_model.dart';

//首页数据拉取类
class HttpModel {
  static const String KEY_COOKIE = "key_cookie";
  static const String KEY_USER = "key_user";

  /// 请求首页banner数据
  static Future<HomePageBannerBean> queryHomeBanner() async {
    final response = await http.get(HttpConstants.HOME_PAGE_URL);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
      print("queryHomeBanner response:" +
          response.toString() +
          ",result:" +
          result.toString());
      return HomePageBannerBean.fromJson(result);
    } else {
      return null;
    }
  }

  ///请求首页文章列表数据
  static Future<HomePageArticleBean> queryHomeArticle(int queryIndex) async {
    print("queryHomeArticle queryIndex:" + queryIndex.toString());
    String url = HttpConstants.HOME_ARTICLE_URL;
    url = url.replaceAll("#", queryIndex.toString());
    print("queryHomeArticle url:" + url);
    final response = await http.get(url);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
//      print("queryHomeArticle response:" +
//          response.toString() +
//          ",result:" +
//          result.toString());
      return HomePageArticleBean.fromJson(result);
    } else {
      return null;
    }
  }

  /// 请求公众号列表数据
  static Future<PubSubscriptionBean> queryPubSubscription() async {
    final response = await http.get(HttpConstants.PUBLIC_SUBSCRIPTION);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
      print("queryPubSubscription response:" +
          response.toString() +
          ",result:" +
          result.toString());
      return PubSubscriptionBean.fromJson(result);
    } else {
      return null;
    }
  }

  ///请求公众号文章列表数据
  static Future<PubSubArticleListBean> queryPubSubArticle(
      String authorId, int queryIndex) async {
    print("queryPubSubArticle queryIndex:" + queryIndex.toString());
    String url = HttpConstants.PUBLIC_SUBSCRIPTION_HISTORY;
    url = url.replaceAll("@", authorId);
    url = url.replaceAll("#", queryIndex.toString());
    print("queryPubSubArticle url:" + url);
    final response = await http.get(url);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
//      print("queryHomeArticle response:" +
//          response.toString() +
//          ",result:" +
//          result.toString());
      return PubSubArticleListBean.fromJson(result);
    } else {
      return null;
    }
  }

  /// 请求搜索热词列表
  static Future<HotKeyBean> queryHotKey() async {
    final response = await http.get(HttpConstants.HOT_KEY);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder(); // fix 中文乱码
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
      print("queryHotKey response:" +
          response.toString() +
          ",result:" +
          result.toString());
      return HotKeyBean.fromJson(result);
    } else {
      return null;
    }
  }

  ///搜索某位作者的文章列表数据
  static Future<HomePageArticleBean> queryAuthorArticle(
      String author, int queryIndex) async {
    print("queryAuthorArticle queryIndex:" +
        queryIndex.toString() +
        "，author：" +
        author);
    String url = HttpConstants.HOME_ARTICLE_URL;
    url = url.replaceAll("#", queryIndex.toString());
//    if (author != null && author != "") {
    url = url + "?author=" + author;
//    }
    print("queryAuthorArticle url:" + url);
    final response = await http.get(url);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
//      print("queryHomeArticle response:" +
//          response.toString() +
//          ",result:" +
//          result.toString());
      return HomePageArticleBean.fromJson(result);
    } else {
      return null;
    }
  }

  ///搜索关键字文章列表数据
  static Future<HomePageArticleBean> queryKeyArticle(
      String key, int queryIndex) async {
    print("queryKeyArticle queryIndex:" + queryIndex.toString());
    String url = HttpConstants.ARTICLE_QUERY;
    url = url.replaceAll("#", queryIndex.toString());
    print("queryKeyArticle url:" + url);
    final response = await http.post(url,
        headers: {"Accept": "application/json"},
        body: {"k": key},
        encoding: Utf8Codec());
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
      print("queryKeyArticle response:" +
          response.toString() +
          ",result:" +
          result.toString());
      return HomePageArticleBean.fromJson(result);
    } else {
      return null;
    }
  }

  ///登录接口
  static Future<UserBean> doLogin(String username, String password) async {
    print("doLogin username:" + username + ",password:" + password);
    String url = HttpConstants.LOGIN;
    print("doLogin url:" + url);
    final response = await http.post(url,
        headers: {"Accept": "application/json"},
        body: {"username": username, "password": password},
        encoding: Utf8Codec());
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
      print("doLogin response.headers:" +
          response.headers.toString() +
          ", response.body:" +
          response.body +
          ",result:" +
          result.toString());

      String cookie = response.headers["set-cookie"];
      print("network cookie:" + cookie);
      UserData.cookie = cookie;
      //保存本地
      SharedPreferencesUtil.saveString(KEY_COOKIE, cookie);
      SharedPreferencesUtil.saveString(KEY_USER, json.encode(result));
//      //保存本地
//      SharedPreferences sp = await SharedPreferences.getInstance();
//      sp.setString(KEY_COOKIE, response.headers["set_cookie"]);
      return UserBean.fromJson(result);
    } else {
      return Future.error(response.body);
    }
  }

  ///注册接口
  static Future<UserBean> doRegister(
      String username, String password, String rePassword) async {
    print("doRegister username:" +
        username +
        ",password:" +
        password +
        ",rePassword:" +
        rePassword);
    String url = HttpConstants.REGISTER;
    print("doRegister url:" + url);
    final response = await http.post(url,
        headers: {"Accept": "application/json"},
        body: {
          "username": username,
          "password": password,
          "repassword": rePassword
        },
        encoding: Utf8Codec());
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
      print("doRegister response.headers:" +
          response.headers.toString() +
          ", response.body:" +
          response.body +
          ",result:" +
          result.toString());

      String cookie = response.headers["set-cookie"];
      print("network cookie:" + cookie);
      UserData.cookie = cookie;
      //保存本地
      SharedPreferencesUtil.saveString(KEY_COOKIE, cookie);
      SharedPreferencesUtil.saveString(KEY_USER, json.encode(result));

      return UserBean.fromJson(result);
    } else {
      return Future.error(response.body);
    }
  }

  ///退出登录
  static Future<ResponseBean> doOutLogin() async {
    String url = HttpConstants.OUT_LOGIN;
    print("doOutLogin url:" + url);
    //获取本地
    String cookie = await SharedPreferencesUtil.getString(HttpModel.KEY_COOKIE);
//    print("本地cookie:" + cookie);
    final response = await http.get(url, headers: {"cookie": cookie});
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
      print("doOutLogin response:" +
          response.body +
          ",result:" +
          result.toString());
      return ResponseBean.fromJson(result);
    } else {
      return Future.error(response.body);
    }
  }

  ///查询收藏文章列表
  static Future<HomePageArticleBean> queryCollectArticle(int queryIndex) async {
    print("queryCollectArticle queryIndex:" + queryIndex.toString());
    String url = HttpConstants.COLLECT_LIST;
    url = url.replaceAll("#", queryIndex.toString());
    print("queryCollectArticle url:" + url);
    //获取本地
    String cookie = await UserData.getCookie();
//    print("本地cookie:" + cookie);
    final response = await http.get(url, headers: {"cookie": cookie});
//    final response = await http.get(url);
    print("queryCollectArticle request.headers:" +
        response.request.headers.toString());

    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
      print("queryCollectArticle response:" +
          response.toString() +
          ",result:" +
          result.toString());
      return HomePageArticleBean.fromJson(result);
    } else {
      return null;
    }
  }

  ///收藏文章
  static Future<ResponseBean> doCollectArticle(int articleId) async {
    print("doCollectArticle articleId:" + articleId.toString());
    String url = HttpConstants.COLLECT_ARTICLE;
    url = url.replaceAll("#", articleId.toString());
    print("doCollectArticle url:" + url);
    //获取本地
    String cookie = await UserData.getCookie();
//    print("本地cookie:" + cookie);
    final response = await http.post(url, headers: {"cookie": cookie});
//    final response = await http.get(url);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
      print("doCollectArticle response:" +
          response.body +
          ",result:" +
          result.toString());
      return ResponseBean.fromJson(result);
    } else {
      return null;
    }
  }

  ///取消收藏文章
  static Future<HomePageArticleBean> doUnCollectArticle(int articleId) async {
    print("doUnCollectArticle articleId:" + articleId.toString());
    String url = HttpConstants.UNCOLLECT_ARTICLE;
    url = url.replaceAll("#", articleId.toString());
    print("doUnCollectArticle url:" + url);
    //获取本地
    String cookie = await UserData.getCookie();
//    print("本地cookie:" + cookie);
    final response = await http.post(url, headers: {"cookie": cookie});
//    final response = await http.get(url);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
      print("doUnCollectArticle response:" +
          response.body +
          ",result:" +
          result.toString());
      return HomePageArticleBean.fromJson(result);
    } else {
      return null;
    }
  }

  ///请求知识体系结构列表数据
  static Future<StudyTreeBean> queryStudyTree() async {
    String url = HttpConstants.QUERY_STUDY_TREE;
    print("queryStudyTree url:" + url);
    final response = await http.get(url);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
//      print("queryHomeArticle response:" +
//          response.toString() +
//          ",result:" +
//          result.toString());
      return StudyTreeBean.fromJson(result);
    } else {
      return null;
    }
  }

  ///请求知识体系文章列表数据
  static Future<HomePageArticleBean> queryStudyTreeArt(
      int queryIndex, int cid) async {
    print("queryStudyTreeArt queryIndex:" +
        queryIndex.toString() +
        ",cid:" +
        cid.toString());
    String url = HttpConstants.QUERY_STUDY_TREE_ART;
    url = url.replaceAll("#", queryIndex.toString());
    url = url.replaceAll("@", cid.toString());
    print("queryStudyTreeArt url:" + url);
    final response = await http.get(url);
    if (response != null && response.statusCode == 200) {
      Utf8Decoder utf8decoder = Utf8Decoder();
      Map<String, dynamic> result =
          json.decode(utf8decoder.convert(response.bodyBytes));
//      print("queryHomeArticle response:" +
//          response.toString() +
//          ",result:" +
//          result.toString());
      return HomePageArticleBean.fromJson(result);
    } else {
      return null;
    }
  }
}
