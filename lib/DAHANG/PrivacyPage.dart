import 'dart:convert';
import 'dart:math' as math;
import 'package:Brain_Plus/DAHANG/PrivacyController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webview_flutter/webview_flutter.dart';

class PrivacyPage extends StatelessWidget {
  String url;

  PrivacyPage({super.key, this.url = ""});

  @override
  Widget build(BuildContext context) {
    return (GetBuilder<PrivacyPageController>(
        init: PrivacyPageController(context, url),
        builder: (controller) {
          return SafeArea(
              bottom: false,
              right: false,
              child: Scaffold(
                  resizeToAvoidBottomInset: false,
                  extendBodyBehindAppBar: true, //
                  appBar: AppBar(
                    leading: IconButton(
                      icon: Image.asset(
                          color: Colors.black,
                          width: 30,
                          height: 30,
                          'assets/liaoxin.png'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                  ),
                  body: Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: WebViewWidget(controller: controller.myController),
                  )));
        }));
  }
}
