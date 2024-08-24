import 'dart:io';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/services.dart';

class ASData {
  static MethodChannel? methodChannel;
  static bool isChange = false;
  static AppsflyerSdk? appsflyerSdk;
  static String key1 = "VcXRPBtj";
  static String key2 = "tGuheF7t";
  static String key3 = "VDzpzZ";
  static initAppsFlyer() {
    final appsFlyerOptions = AppsFlyerOptions(
        afDevKey: key1 + key2 + key3,
        appId: Platform.isIOS ? "346576879" : "",
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
