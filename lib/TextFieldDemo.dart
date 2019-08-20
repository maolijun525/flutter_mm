import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TextFieldDemoState();
  }
}

class TextFieldDemoState extends State<TextFieldDemo> {
  //手机号的控制器
  TextEditingController phoneController = TextEditingController();

  //密码的控制器
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("文本输入控件"),
      ),
      body: new Column(
        children: <Widget>[
          new TextField(
              //最普通的TextField，没有任何提示
              ),
          new TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(20.0),
              icon: Icon(Icons.text_fields),
              labelText: '这里是提示文案',
              helperText: '这是文本框内提示文案',
            ),
            onChanged: _textFieldChanged, //文案输入时的事件监听
            autofocus: false,
          ),
          TextField(
            maxLength: 30,
            //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
            maxLines: 1,
            //最大行数
            autocorrect: true,
            //是否自动更正
            autofocus: true,
            //是否自动对焦
            obscureText: true,
            //是否是密码
            textAlign: TextAlign.center,
            //文本对齐方式
            style: TextStyle(fontSize: 30.0, color: Colors.blue),
            //输入文本的样式
            inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
            //允许的输入格式
            onChanged: (text) {
              //内容改变的回调
              print('change $text');
            },
            onSubmitted: (text) {
              //内容提交(按回车)的回调
              print('submit $text');
            },
            enabled: true, //是否禁用
          ),
          new Text(
            "下面是登录演示",
            style: new TextStyle(
                color: const Color(0xffff9900),
                decoration: TextDecoration.underline,
                decorationColor: const Color(0xffff9900),
                fontSize: 21.0),
          ),
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              icon: Icon(Icons.phone),
              labelText: '请输入用户名)',
              helperText: '请输入11位手机号',
            ),
            autofocus: false,
          ),
          TextField(
              controller: passController,
//              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10.0),
                icon: Icon(Icons.lock),
                labelText: '请输入密码)',
              ),
              obscureText: true),
          RaisedButton(
            onPressed: _login,
            child: Text('登录'),
          ),
          TextField(
            //改成红色光标
            cursorColor: Colors.red,
            cursorRadius: Radius.circular(16.0),
            cursorWidth: 16.0,
          ),
          TextField(
            textCapitalization: TextCapitalization.sentences,
//            textCapitalization: TextCapitalization.characters,
//            textCapitalization: TextCapitalization.words,
//            textCapitalization: TextCapitalization.none,
//            textCapitalization: TextCapitalization.characters,
          ),
        ],
      ),
    );
  }

  void _login() {
    print({'phone': phoneController.text, 'password': passController.text});
    if (phoneController.text.length != 11) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('手机号码格式不对'),
              ));
    } else if (passController.text.length == 0) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('请填写密码'),
              ));
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('登录成功'),
              ));
      phoneController.clear();
    }
  }
}

void _textFieldChanged(String str) {
  print(str);
}

void main() {
  runApp(new MaterialApp(
    title: "输入控件案例",
    theme: new ThemeData(primaryColor: Colors.deepOrangeAccent),
    home: new TextFieldDemo(),
  ));
}
