import 'package:flutter/material.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';
import 'package:flutter_mm/project/pages/Home.dart';
import 'package:flutter_mm/project/pages/LoginPage.dart';
import 'package:flutter_mm/project/pages/RegisterPage.dart';
import 'package:flutter_mm/project/util/UserData.dart';

class UserWidget extends StatefulWidget {
  const UserWidget({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserWidgetState();
  }
}

class UserWidgetState extends State<UserWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      child: Drawer(
          child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40),
            alignment: Alignment.topLeft,
            height: 180,
            color: Theme.of(context).accentColor,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 15, top: 40),
                  child: ClipOval(
                    child: Image.network(
                      "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1562115289&di=2097223e93c2bc5217cf2b79ca3fcd0e&src=http://pic.qjimage.com/ph115/high/ph3854-p03311.jpg",
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 15, top: 25),
                    child: Text(
                      UserData.user?.nickname ?? "呆萌的小狗",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.add_to_home_screen),
            title: Text("登录"),
            onTap: () {
              _toLogin();
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("注册"),
            onTap: () {
              _toRegister();
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_run),
            title: Text("退出登录"),
            onTap: () {
              _toLoginOut();
            },
          ),
        ],
      )),
    );
  }

  void _toLogin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  void _toRegister() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return RegisterPage();
    }));
  }

  void _toLoginOut() {
    HttpModel.doOutLogin().then((response) {
      print("退出登录完毕 response:" + response.toString());
      UserData.user = null;
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return Home();
      }));
    }).catchError((e) {
      print(e.toString());
    });
  }
}
