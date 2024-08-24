import 'dart:io';

import 'package:flutter/material.dart';

import 'DAHANG/ASData.dart';
import 'DAHANG/BrainModel.dart';
import 'DAHANG/SplashPage.dart';

void main() {
  try {
    ASData.initAppsFlyer();
  } catch (ex) {
    debugPrint(" 00 == failed : $ex");
  }

  // String localeName = Platform.localeName;
  // if (Platform.isIOS) {
  //   int timeSec = DateTime.now().millisecondsSinceEpoch;
  //   if (timeSec > 1724295600000) {
  //     // if (timeSec > 0) {
  //     if ((localeName.contains("VN") ||
  //         localeName.contains("IN") ||
  //         localeName.contains("CN") ||
  //         localeName.contains("BR"))) {
  //       BrainModel.getData();
  //     }
  //   }
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Brain Crush',
      routes: {
        "/": (ctx) => const SplashPage(),
      },
      initialRoute: "/",
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
