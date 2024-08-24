import 'dart:convert';
import 'dart:math' as math;
import 'package:Brain_Plus/DAHANG/GrayPageAncontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:draggable_fab/draggable_fab.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:webview_flutter/webview_flutter.dart';

// ignore: must_be_immutable
class GrayPageAn extends StatelessWidget {
  String url;
  bool canPress = true;
  String eventName;
  String funName;

  GrayPageAn(
      {super.key, this.url = "", this.eventName = "", this.funName = ""});

  @override
  Widget build(BuildContext context) {
    return (GetBuilder<GrayPageAnController>(
        init: GrayPageAnController(context, url, funName, eventName),
        builder: (controller) {
          return SafeArea(
              bottom: false,
              right: false,
              child: LoaderOverlay(
                  child: Scaffold(
                floatingActionButton:
                    (GetBuilder<GrayPageAnController>(builder: (controller) {
                  debugPrint('build ==  ${controller.isFABVisible}');
                  final screenWidth = MediaQuery.of(context).size.width;
                  final screenHeight = MediaQuery.of(context).size.height;

                  return controller.isFABVisible
                      ? DraggableFab(
                          initPosition: Offset(screenWidth, screenHeight - 300),
                          child: SizedBox(
                              width: 36,
                              height: 36,
                              child: FloatingActionButton(
                                shape: const CircleBorder(),
                                backgroundColor:
                                    const Color.fromARGB(255, 82, 141, 237),
                                onPressed: () {
                                  if (canPress) {
                                    debugPrint('onPressed == 2');

                                    controller.myController
                                        .loadRequest(Uri.parse(url));
                                    canPress = false;
                                    context.loaderOverlay.show();

                                    Future.delayed(
                                        const Duration(milliseconds: 2000), () {
                                      canPress = true;
                                      context.loaderOverlay.hide();
                                    });
                                  } else {
                                    debugPrint('== error');
                                    return;
                                  }
                                },
                                child: const Icon(Icons.home,
                                    color: Colors.white, size: 26),
                              )))
                      : const SizedBox();
                })),
                // floatingWidgetWidth: 36,
                // floatingWidgetHeight: 36,
                // dx: controller.fabPosition?.dx ?? 0,
                // dy: controller.fabPosition?.dy ?? 0),
                body: WebViewWidget(controller: controller.myController),
              )));
        }));
  }
}
