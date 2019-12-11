import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mm/project/pages/SearchPage.dart';
import 'package:flutter_mm/project/widget/ArticlesListWidget.dart';
import 'package:flutter_mm/project/widget/CollectArticlesListWidget.dart';
import 'package:flutter_mm/project/widget/StudyTreeListWidget.dart';

class HomeMiddlerPage extends StatefulWidget {
  // This widget is the root of your application.
  HomeMiddlerPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new HomeMiddlerPageState();
  }
}

class HomeMiddlerPageState extends State<HomeMiddlerPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              backgroundColor: Colors.lightBlue,
              bottom: TabBar(
                tabs: [
                  Tab(text: "我的收藏"),
                  Tab(text: "分类学习"),
                  Tab(
                      icon: IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.search),
                    onPressed: () {
                      print("click search");
                      showSearch(context: context, delegate: SearchPage());
                    },
                  ))
                ],
                controller: _tabController,
                isScrollable: true,
              ),
            ),
            preferredSize: Size.fromHeight(50)),
        body: TabBarView(
          controller: _tabController,
          children: [
            CollectArticlesListWidget(),
            StudyTreeListWidget(),
          ],
        ));
  }
}
