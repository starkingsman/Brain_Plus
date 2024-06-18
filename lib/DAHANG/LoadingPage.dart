import 'package:draggable_fab/draggable_fab.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'InitData.dart';
import 'NativePage.dart';

class GrayPage extends StatefulWidget {
  final String url;
  final String fName;

  const GrayPage({super.key, this.url = "", this.fName = ""});

  @override
  State<GrayPage> createState() => _LayerPageState();
}

class _LayerPageState extends State<GrayPage> {
  bool isFABVisible = false;
  bool canPress = true;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        isFABVisible = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        // top: false,
        // bottom: false,
        // right: false,
        child: LoaderOverlay(
            child: Scaffold(
      floatingActionButton: isFABVisible
          ? DraggableFab(
              initPosition: Offset(MediaQuery.of(context).size.width,
                  MediaQuery.of(context).size.height - 300),
              child: SizedBox(
                  width: 36,
                  height: 36,
                  child: FloatingActionButton(
                    shape: const CircleBorder(),
                    backgroundColor: const Color.fromARGB(255, 82, 141, 237),
                    onPressed: () {
                      if (canPress) {
                        flutterToNative("");
                        canPress = false;
                        context.loaderOverlay.show();

                        Future.delayed(const Duration(milliseconds: 2000), () {
                          canPress = true;
                          context.loaderOverlay.hide();
                        });
                      } else {
                        return;
                      }
                    },
                    child:
                        const Icon(Icons.home, color: Colors.white, size: 26),
                  )))
          : const SizedBox(),
      body: NativePage(url: widget.url, funName: widget.fName),
    )));
  }

  Future<void> flutterToNative(String message) async {
    await InitData.methodChannel?.invokeMethod('flutterToNative', message);
  }
}
