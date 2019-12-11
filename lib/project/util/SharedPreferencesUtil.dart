import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtil {
//读取数据
  static Future<String> getString(String keyName) async {
    print('SP 进入到读取数据');
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String data = await sharedPreferences.getString(keyName);
    print('SP 进入到读取数据-返回数据');
    return data;
  }

//保存数据
  static Future<bool> saveString(String keyName, String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    bool isOk = await sharedPreferences.setString(keyName, value);
    return isOk;
  }
}
