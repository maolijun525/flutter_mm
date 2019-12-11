import 'package:flutter/material.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';
import 'package:flutter_mm/project/pages/Home.dart';
import 'package:flutter_mm/project/pages/HomePage.dart';
import 'package:flutter_mm/project/util/SharedPreferencesUtil.dart';
import 'package:flutter_mm/project/util/UserData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_mm/project/util/Toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  TextEditingController userController = new TextEditingController();

  TextEditingController passController = new TextEditingController();

  TextEditingController _rePassController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("注册"),
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
          TextField(
            controller: _rePassController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.lock),
              labelText: '请确认密码)',
              helperText: '跟上面的密码一致',
            ),
            autofocus: false,
          ),
          RaisedButton(
            onPressed: _register,
            child: Text('注册'),
          ),
        ],
      ),
    );
  }

  void _register() {
    String username = userController.text;
    String password = passController.text;
    String rePassword = _rePassController.text;

    HttpModel.doRegister(username, password, rePassword).then((response) {
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

      print("注册完毕");
    }).catchError((e) {
      print(e.toString());
    });
  }

  void _getUser() async {
    //获取本地
    SharedPreferencesUtil.getString(HttpModel.KEY_COOKIE).then((value) {
      print("本地cookie:" + value);
    });

//    SharedPreferences sp = await SharedPreferences.getInstance();
//    String cookie = sp.getString(HttpModel.KEY_COOKIE);
//    setState(() {
//      print("本地cookie:" + cookie);
//    });
  }
}
