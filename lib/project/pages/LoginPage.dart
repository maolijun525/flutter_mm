import 'package:flutter/material.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';
import 'package:flutter_mm/project/pages/Home.dart';
import 'package:flutter_mm/project/util/SharedPreferencesUtil.dart';
import 'package:flutter_mm/project/util/Toast.dart';
import 'package:flutter_mm/project/util/UserData.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  TextEditingController userController = new TextEditingController();

  TextEditingController passController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: userController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.phone),
              labelText: '请输入用户名)',
              helperText: '任意文字',
            ),
            autofocus: true,
          ),
          TextField(
            controller: passController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.lock),
              labelText: '请输入密码)',
              helperText: '随便填，记得就行',
            ),
            autofocus: false,
          ),
          RaisedButton(
            onPressed: _login,
            child: Text('登录'),
          ),
        ],
      ),
    );
  }

  void _login() {
    String userName = userController.text;
    String pass = passController.text;

    HttpModel.doLogin(userName, pass).then((response) {
      if (response?.errorCode != 0) {
        Toast(context, response.errorMsg).show();
//        showDialog(
//            context: context,
//            builder: (context) => AlertDialog(
//                  title: Text(response.errorMsg),
//                ));
      } else {
        UserData.user = response.data;
        _getUser();
        //go home
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return Home();
        }));
      }

      print("登录完毕");
    }).catchError((e) {
      print(e.toString());
    });
  }

  void _getUser() async {
    //获取本地
    SharedPreferencesUtil.getString(HttpModel.KEY_COOKIE).then((v) {
      if (v != null && v.length > 0) {
        print("登录内存cookie:" + UserData.cookie);
        print("登录本地cookie:" + v);
      } else {
        print("登录本地cookie: empty");
      }
    });
  }
}
