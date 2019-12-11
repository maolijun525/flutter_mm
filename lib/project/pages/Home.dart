import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mm/project/pages/HomeMiddlerPage.dart';
import 'package:flutter_mm/project/pages/HomePage.dart';
import 'package:flutter_mm/project/pages/PubSubscriptionPage.dart';
import 'package:flutter_mm/project/util/UserData.dart';
import 'package:flutter_mm/project/widget/UserWidget.dart';

class Home extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeState();
  }
}

class HomeState extends State<Home> {
  int _currentIndex = 0;
  String appBarTitle = "maomao的Flutter项目";

  PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //自动登录
    UserData.setCookie();
    UserData.setUser();
  }

  void _setAppBarTitle() {
    if (_currentIndex == 0) {
      this.appBarTitle = "maomao的Flutter项目";
    } else if (_currentIndex == 1) {
      this.appBarTitle = "福利";
    } else {
      this.appBarTitle = "公众号";
    }
  }

  @override
  Widget build(BuildContext context) {
    // AppBar - 顶部标题栏；PageView - 中间显示的Page页面；BottomNavigationBar - 底部导航栏
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          );
        }),
      ),
      drawer: UserWidget(),
      body: PageView(
        controller: _pageController,
        children: <Widget>[
          HomePage(),
          HomeMiddlerPage(),
          PubSubscriptionPage()
        ],
        onPageChanged: (index) {
          setState(() {
            this._currentIndex = index;
            _setAppBarTitle();
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            // 点击跳转对应的PageView
            _pageController.jumpToPage(index);
            setState(() {
              this._currentIndex = index;
              _setAppBarTitle();
            });
          },
          currentIndex: _currentIndex,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text("首页"),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.apps),
                title: Text("福利"),
                backgroundColor: Colors.white),
            BottomNavigationBarItem(
                icon: Icon(Icons.map),
                title: Text("公众号"),
                backgroundColor: Colors.white)
          ]),
    );
  }
}
