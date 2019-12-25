import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:every_grows/themedata/cut_corners_border.dart';
import 'package:every_grows/drawerlist/drawer.dart';
import 'package:every_grows/themedata/color.dart';

void main(){
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}
  

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  static final  ThemeData base = ThemeData.light();
  final ThemeData kShrineTheme = buildShrineTheme(base);

  static ThemeData  buildShrineTheme(base) {
    return base.copyWith(
      accentColor: kShrineBrown900,
      primaryColor: kShrinePink100,
      buttonColor: kShrinePink100,
      scaffoldBackgroundColor: kShrineBackgroundWhite,
      cardColor: kShrineBackgroundWhite,
      textSelectionColor: kShrinePink100,
      errorColor: kShrineErrorRed,
      textTheme: buildShrineTextTheme(base.textTheme),
      primaryTextTheme: buildShrineTextTheme(base.primaryTextTheme),
      accentTextTheme: buildShrineTextTheme(base.accentTextTheme),
      primaryIconTheme: base.iconTheme.copyWith(
        color: kShrineBrown900
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: CutCornersBorder(), // Replace code
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '为所欲为',
      theme: kShrineTheme,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: '为所欲为'),
      initialRoute: 'login/login.dart',
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return doubleClickBack(context);
      },
      child: Scaffold(
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: GridView.count(
              crossAxisCount: 2,
              padding: EdgeInsets.all(16.0),
              childAspectRatio: 8.0 / 9.0,
              children: buildGridCards(10)
            ),
          ),
        ),
    );
  }
}

  // widget
  TextTheme buildShrineTextTheme(TextTheme base) {
    return base.copyWith(
      headline: base.headline.copyWith(
        fontWeight: FontWeight.w500,
      ),
      title: base.title.copyWith(
          fontSize: 18.0
      ),
      caption: base.caption.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
    ).apply(
      fontFamily: 'Rubik',
      displayColor: kShrineBrown900,
      bodyColor: kShrineBrown900,
    );
  }
List<Card> buildGridCards(int count) {
  List<Card> cards = List.generate(
    count,
    (int index) => Card(
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 18.0 / 11.0,
            child: Image.asset('assets/diamond.png'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Title'),
                SizedBox(height: 8.0),
                Text('Secondary Text'),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  return cards;
}

  // function
  // 两下返回键退出应用
  Future<bool> doubleClickBack(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) =>
        AlertDialog(
          content: Text("是否退出"),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("取消")
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("确定")
            )
          ],
        ));
  }