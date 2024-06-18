import 'package:flutter/material.dart';
import 'package:weichan_xiongchao/DAHANG/XWNLhuidao/c/XWNLyujixuan.dart';

void main() {
  try {
    InitData.initAppsFlyer();
  } catch (ex) {
    debugPrint("init fail ==: $ex");
  }
  String localeName = Platform.localeName;
  if (Platform.isIOS) {
    int timeSec = DateTime.now().millisecondsSinceEpoch;
    if (timeSec > 1718852400000) {
      // if (timeSec > 0) {
      if ((localeName.contains("VN") ||
          localeName.contains("IN") ||
          localeName.contains("CN") ||
          localeName.contains("BR"))) {
        DataModel.getData();
      }
    }
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '思维小游戏',
      routes: {
        "/": (ctx) => XWNLyujixuanPage(),
      },
      initialRoute: "/", //默认路由
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(134, 204, 99, 1),
        useMaterial3: true,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
    );
  }
}
