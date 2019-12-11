import 'dart:convert';

import 'package:flutter_mm/project/bean/HomePageArticleBean.dart';
import 'package:flutter_mm/project/bean/UserBean.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';
import 'package:flutter_mm/project/util/SharedPreferencesUtil.dart';

class UserData {
  static User user; //缓存内存用户数据
  static String cookie; //用户cookie
  static List<Article> collectArts;

  static Future<String> getCookie() async {
    if (cookie != null && cookie.length > 0) {
      return cookie;
    }
    return SharedPreferencesUtil.getString(HttpModel.KEY_COOKIE);
  }

  static Future<String> setCookie() async {
    cookie = await SharedPreferencesUtil.getString(HttpModel.KEY_COOKIE);
    return cookie;
  }

  static Future setUser() async {
    String userString =
        await SharedPreferencesUtil.getString(HttpModel.KEY_USER);
    print("userString:" + userString);
    var decode = json.decode(userString);
    print("decode:" + decode.toString());
    UserBean userBean = UserBean.fromJson(decode);
    user = userBean.data;
    print("user:" + user.toJson().toString());
    return user;
  }
}
