import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class StaggeredGridViewDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StaggeredGridView 瀑布流"),
      ),
      body: Column(children: [
        Expanded(
            child: StaggeredGridView.countBuilder(
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          crossAxisCount: 4,
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) => new Container(
              color: index.isEven ? Colors.green : Colors.yellow,
              child: new Center(
                child: new CircleAvatar(
                  backgroundColor: Colors.white,
                  child: new Text('$index'),
                ),
              )),
          staggeredTileBuilder: (int index) =>
              new StaggeredTile.count(2, index.isEven ? 2 : 1),
        )
//          child: StaggeredGridView.countBuilder(
//              staggeredTileBuilder: (index) => StaggeredTile.count(2, index.isEven ? 2 : 1),
////            controller: _scrollController,
//              itemCount: 50,
////              primary: false,
//              crossAxisCount: 4,
//              mainAxisSpacing: 4.0,
//              crossAxisSpacing: 4.0,
//              itemBuilder: (context, position) {
//                Widget item;
//                if (position < 10) {
//                  item = FlatButton.icon(
//                    icon: Icon(Icons.info),
//                    label: Text("" + position.toString()),
//                    color: Colors.green,
//                    onPressed: () {},
//                  );
//                } else {
//                  item = Container(
//                    color: Colors.blue,
//                    child: Icon(
//                      Icons.airplanemode_active,
//                      color: Colors.white,
//                    ),
//                  );
//                }
//                return item;
//              }),
            ),
      ]),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: "StaggeredGridView 瀑布流",
    theme: ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: StaggeredGridViewDemo(),
  ));
}
