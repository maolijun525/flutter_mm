import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("图片控件"),
        ),
        body: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: new Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              new Image(
                image: new AssetImage('assets/images/image1.jpeg'),
                width: 100,
                height: 120,
              ),
              Image(
                image: AssetImage("assets/images/image1.jpeg"),
                width: 100.0,
                height: 120,
                color: Colors.blue,
                colorBlendMode: BlendMode.difference,
              ),
              Image.asset(
                'assets/images/image1.jpeg',
                width: 100,
                height: 120,
              ),
              Image(
                image: AssetImage("assets/images/image1.jpeg"),
                width: 100.0,
                height: 150.0,
                repeat: ImageRepeat.repeatY,
              ),
              Image(
                image: FileImage(File(
                    "/Users/maomao/Downloads/weibo_android_sdk-master/flutter_mm/assets/images/image2.jpeg")),
                width: 100.0,
                height: 80,
              ),
              Image.file(
                File(
                    "/Users/maomao/Downloads/weibo_android_sdk-master/flutter_mm/assets/images/image2.jpeg"),
                width: 100.0,
                height: 80,
              ),
              Image(
                image: NetworkImage(
                    "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566206241&di=7ac44909ccd5e1c89f63aa188e159305&imgtype=jpg&er=1&src=http%3A%2F%2Fdiy.qqjay.com%2Fu2%2F2014%2F1012%2F687570a473f4aacb5b34aa77fa746e1f.jpg"),
                width: 100.0,
                height: 120,
              ),
              Image.network(
                "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1566206241&di=7ac44909ccd5e1c89f63aa188e159305&imgtype=jpg&er=1&src=http%3A%2F%2Fdiy.qqjay.com%2Fu2%2F2014%2F1012%2F687570a473f4aacb5b34aa77fa746e1f.jpg",
                width: 100.0,
                height: 120,
              )
            ],
          ),
        ));
  }
}

void main() {
  runApp(new MaterialApp(
    title: "Image案例",
    theme: new ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: new ImageDemo(),
  ));
}
