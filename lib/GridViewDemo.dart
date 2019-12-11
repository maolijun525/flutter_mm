import 'package:flutter/material.dart';
import 'package:flutter_mm/MyIcons.dart';

class GridViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GridViewDemo 网格控件"),
      ),
      body: Column(children: [
        Expanded(
          child: GridView.builder(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 100,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2,
              ),
              itemCount: 50,
              itemBuilder: (BuildContext context, int position) {
                Widget item;
                if (position < 10) {
                  item = FlatButton.icon(
                    icon: Icon(Icons.info),
                    label: Text("" + position.toString()),
                    color: Colors.green,
                    onPressed: () {},
                  );
                } else {
                  item = Container(
                    color: Colors.blue,
                    child: Icon(
                      Icons.airplanemode_active,
                      color: Colors.white,
                    ),
                  );
                }
                return item;
              }),
        ),
        Expanded(
          child: GridView.extent(
            maxCrossAxisExtent: 80,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 2,

//        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
//          maxCrossAxisExtent: 80,
//          mainAxisSpacing: 10,
//          crossAxisSpacing: 10,
//          childAspectRatio: 2,
//        ),

//      SliverGridDelegateWithFixedCrossAxisCount(
//          crossAxisCount: 3,
//          mainAxisSpacing: 20,
//          crossAxisSpacing: 10,
//          childAspectRatio: 2,
//        ),
            children: <Widget>[
              Container(
                color: Colors.green,
                child: Icon(Icons.ac_unit),
              ),
              Container(
                color: Colors.green,
                child: Icon(Icons.add),
              ),
              Container(
                color: Colors.green,
                child: Icon(Icons.map),
              ),
              Container(
                color: Colors.green,
                child: Icon(Icons.print),
              ),
              Container(
                color: Colors.green,
                child: Icon(Icons.accessibility),
              ),
              Container(
                color: Colors.green,
                child: Icon(Icons.access_alarm),
              ),
              Container(
                color: Colors.green,
                child: Icon(Icons.accessible),
              ),
              Container(
                color: Colors.green,
                child: Icon(Icons.accessibility_new),
              ),
              Container(
                color: Colors.green,
                child: Icon(Icons.accessible_forward),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: "GridView网格控件",
    theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: GridViewDemo(),
  ));
}
