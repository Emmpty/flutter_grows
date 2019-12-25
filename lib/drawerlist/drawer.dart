import 'package:flutter/material.dart';
import 'package:every_grows/themedata/color.dart';

class Test extends StatefulWidget {
  _TestState createState() => _TestState();
}
var drawerData = [
    {
      'text': 'aaaa',
      'icon': new Icon(IconData(0xe618, fontFamily: 'IconFont',),color: Colors.red[400],),
      'pagePath': Test() 
    },
    {
      'text': 'bbbb',
      'icon': new Icon(IconData(0xe618, fontFamily: 'IconFont',),color: Colors.red[400],),
      'pagePath': Test() 
    },
    {
      'text': 'cccc',
      'icon': new Icon(IconData(0xe618, fontFamily: 'IconFont',),color: Colors.red[400],),
      'pagePath': Test() 
    },
    {
      'text': 'dddd',
      'icon': new Icon(IconData(0xe618, fontFamily: 'IconFont',),color: Colors.red[400],),
      'pagePath': Test() 
    },
  ];

class _TestState extends State<Test>
  with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Theme(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('aaaa'),
        ),
        body: Container(
          // color: Color.fromRGBO(35, 35, 35, 1),
          child: Text('bbbbb',)
        )),
    // data: ThemeData.dark(),
    );
  }
}

//左测弹框
  Widget buildDrawer(BuildContext context){
    return new Drawer(
      child: new ListView(
        padding: EdgeInsets.zero,   //解决Drawer上的系统状态栏颜色不同
        children: <Widget>[
          new UserAccountsDrawerHeader(   //Material内置控件
            accountName: new Text('Emmmpty',
              style: new TextStyle(
                  fontSize: 20
              ),
            ), //用户名
            currentAccountPicture: new GestureDetector( //用户头像
              child: new CircleAvatar(    //圆形图标控件
                backgroundImage: new ExactAssetImage('images/touxiang.jpg'),
                //长方形
                //child: new Image.asset('./images/touxiang.jpg',fit: BoxFit.cover,),
            ),
            ),
            decoration: new BoxDecoration(
              image: new DecorationImage(
                fit: BoxFit.cover,
                // image: new NetworkImage('')
                image: new ExactAssetImage('images/xiaochou.jpg'),
              ),
            ),
          ),
          //遍历列表
          buildListData(context, drawerData),
          new Divider(),    //分割线控件
          new ListTile(   //退出按钮
            leading: new Icon(Icons.arrow_right, color: kShrinePink100),
            title: new Text('退出'),
            trailing: new Icon(Icons.cancel),
           //onTap: () => Navigator.of(context).pop(),   //点击后收起侧边栏
            onTap: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }

  // 列表
  Widget buildListData(BuildContext context, drawerData) {
    List<Widget> list = [];
    Widget content;
    for(int item=0; item < drawerData.length; item++) {
      list.add(
        new ListTile(
          isThreeLine: false,
          leading: drawerData[item]['icon'],
          title: new Text(drawerData[item]['text']),
          trailing: new Icon(Icons.arrow_right),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) {
                return drawerData[item]['pagePath'];
              },
            ));
          },
        ),
      );
    }
    content = new Column(
        children: list
    );
    return content;
  }