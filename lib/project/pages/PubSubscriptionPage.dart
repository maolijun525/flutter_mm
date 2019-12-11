import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mm/project/bean/PubSubscriptionBean.dart';
import 'package:flutter_mm/project/model/HttpModel.dart';
import 'package:flutter_mm/project/widget/SubscriptionListWidget.dart';

class PubSubscriptionPage extends StatefulWidget {
  PubSubscriptionPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new PubSubscriptionPageState();
  }
}

//AutomaticKeepAliveClientMixin<PubSubscriptionPage> 用于缓存页面，不用每次切换都刷新页面
//SingleTickerProviderStateMixin 用于辅助实现tab功能
class PubSubscriptionPageState extends State<PubSubscriptionPage>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<PubSubscriptionPage> {
  List<Subscription> _tabData = [];

  List<Tab> _tabs = [];

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(length: 14, vsync: this);
    _getTabData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    if (_tabs.length <= 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
          appBar: PreferredSize(
              child: AppBar(
                bottom: TabBar(
                  tabs: _tabs,
                  controller: _tabController,
                  isScrollable: true,
                ),
              ),
              preferredSize: Size.fromHeight(50)),
          body: TabBarView(
            controller: _tabController,
            children: _tabData.map((item) {
//            return Container(
//              child: Text(item.name),
//            );
              return SubscriptionListWidget(id: item.id);
            }).toList(),
          ));
    }
  }

  void _getTabData() {
    HttpModel.queryPubSubscription().then((response) {
      _tabData = response?.data ?? [];
      print("_tabData" + _tabData.toString());
      setState(() {
        _tabs?.clear();
        _tabData?.forEach((item) {
          _tabs.add(Tab(text: item.name));
        });
        print("_tabs" + _tabs.toString());
      });
    }).catchError((e) {
      print(e.toString);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
//    if (_tabController != null) {
//      _tabController.dispose();
//    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
