import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPageController extends GetxController {
  bool mCanGoBack = false;
  late WebViewController myController;
  ScrollController scrollController = ScrollController();
  String mUrl = "";

  BuildContext context;
  PrivacyPageController(this.context, this.mUrl);

  @override
  void onInit() {
    myController = WebViewController()
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
}
