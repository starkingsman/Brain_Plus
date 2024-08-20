import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'ASData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativePage extends StatelessWidget {
  final String url;
  final String funName;
  const NativePage({super.key, this.url = "", required this.funName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: NativeView(url: url, funName: funName)));
  }
}

class NativeView extends StatelessWidget {
  final String url;
  final String funName;
  final String eventName = "eventName";
  const NativeView({super.key, this.url = "", required this.funName});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return const Text("no support");
    }

    if (Platform.isAndroid) {}

    if (Platform.isIOS) {
      return UiKitView(
        viewType: 'BrainPlus',
        creationParams: <String, dynamic>{'key': url, 'function': funName},
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }

    return const Text("no support");
  }

  void _onPlatformViewCreated(int id) {
    ASData.methodChannel = const MethodChannel('BrainPlus');
    ASData.methodChannel?.setMethodCallHandler((call) async {
      switch (call.method) {
        case 'nativeToFlutter':
          final result = call.arguments as String;
          logEvent(result);
          break;
      }
    });
  }

  Future<bool?> logEvent(String message) async {
    bool? result;
    String eValue = "eventValue";
    String strIsFirstCharge = "isFirstDeposit";
    String strAmout = "amount";
    bool isFirstDeposit = false;
    int amount = 0;
    Map<dynamic, dynamic> eventValue = {};

    // Map<dynamic, dynamic> jsonObj = {
    //   "eventName": "chargeSuccess",
    //   "eventValue": {"isFirstCharge": false, "amount": 999}
    // };
    try {
      final jsonObj = json.decode(message);
      String eventName = jsonObj[this.eventName] ?? {};
      Map<dynamic, dynamic> objectValue = jsonObj[eValue] ?? {};
      if (objectValue.isNotEmpty) {
        isFirstDeposit = objectValue[strIsFirstCharge] as bool? ?? false;
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
}
