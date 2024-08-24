import 'dart:convert';

import 'package:Brain_Plus/DAHANG/ASData.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GrayPageAnController extends GetxController {
  bool mCanGoBack = false;
  late WebViewController myController;
  ScrollController scrollController = ScrollController();
  Offset? fabPosition;
  bool isFABVisible = false;
  String mUrl = "";
  String funName = "";
  String? eventName = "";
  BuildContext context;
  GrayPageAnController(this.context, this.mUrl, this.funName, this.eventName);

  @override
  void onInit() {
    debugPrint("00 == $funName");
    debugPrint("00 == $eventName");

    Future.delayed(const Duration(seconds: 4), () {
      // testFun();
      isFABVisible = true;
      update();
    });

    myController = WebViewController()
      ..addJavaScriptChannel(funName, onMessageReceived: (message) {
        debugPrint("onReceived 2== ${message.message}");
        logEvent(message);
      })
      ..setNavigationDelegate(NavigationDelegate(
        onPageStarted: (String url) {},
        onWebResourceError: (WebResourceError error) {
          debugPrint("error == : ${error.description}");
        },
        onProgress: (int progress) {},
        onPageFinished: (String url) {},
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
        onUrlChange: (UrlChange change) {
          mUrl = change.url ?? mUrl;
          checkCanGoBack();
        },
      ))
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(
        Uri.parse(mUrl),
      );

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  checkCanGoBack() async {
    bool canGoBack = await myController.canGoBack();

    if (mCanGoBack != canGoBack) {
      mCanGoBack = canGoBack;
      // update();
    }
  }

  testFun() async {
    bool? result = await ASData.appsflyerSdk?.logEvent("login", {});
    debugPrint("== AS : $eventName ");

    debugPrint("== AS log : $result");
    showSimpleDialog(context, "login");
  }

  Future<bool?> logEvent(JavaScriptMessage message) async {
    bool? result;
    String eValue = "eventValue";
    String strIsFirstCharge = "isFirstDeposit";
    String strAmout = "amount";
    bool isFirstDeposit = false;
    int amount = 0;
    Map<dynamic, dynamic> eventValue = {};

    try {
      final jsonObj = json.decode(message.message);
      showSimpleDialog(context, message.message);

      String eventName = jsonObj[this.eventName] ?? {};
      Map<dynamic, dynamic> objectValue = jsonObj[eValue] ?? {};
      if (objectValue.isNotEmpty) {
        isFirstDeposit = objectValue[strIsFirstCharge] ?? false;
        amount = objectValue[strAmout] as int;
        eventName = isFirstDeposit ? "firstCharge" : "secondCharge";
        eventValue.putIfAbsent("af_revenue", () => amount);
      }

      result = await ASData.appsflyerSdk?.logEvent(eventName, eventValue);
      debugPrint("== AS : $eventName  $eventValue");

      debugPrint("== AS log : $result");
    } catch (e) {
      debugPrint("== : $e");
      return false;
    }
    return true;
  }

  void showSimpleDialog(BuildContext context, String message) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Event'),
          children: <Widget>[
            SimpleDialogOption(
              child: Text(message),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
