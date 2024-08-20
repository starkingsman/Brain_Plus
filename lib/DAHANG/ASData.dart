import 'dart:io';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/services.dart';

class ASData {
  static MethodChannel? methodChannel;
  static bool login = false;
  static AppsflyerSdk? appsflyerSdk;
  static initAppsFlyer() {
    final appsFlyerOptions = AppsFlyerOptions(
        afDevKey: "VcXRPBtjtGuheF7tVDzpzZ",
        appId: Platform.isIOS ? "6504292895" : "",
        showDebug: false,
        timeToWaitForATTUserAuthorization: 50,
        disableAdvertisingIdentifier: false,
        disableCollectASA: false);

    appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
    appsflyerSdk?.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true);
  }
}
