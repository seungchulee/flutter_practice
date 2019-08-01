import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';


Future main() async {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}
class _MyAppState extends State<MyApp> {
  final Completer<InAppWebViewController> _controller =
  Completer<InAppWebViewController>();

  InAppWebViewController webView;
  String url = "";
  double progress = 0;
  int check = 0;
  int leftcount=0;
  int rightcount=0;
  int favoritecount=0;
  int upcount=0;
  int downcount=0;
  int initialDragTimeStamp;
  int currentDragTimeStamp;
  int timeDelta;
  double initialPositionY;
  double currentPositionY;
  double initialPositionX;
  double currentPositionX;
  double positionXDelta;
  double positionYDelta;

  Widget favoriteButton() {
    return FutureBuilder<InAppWebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<InAppWebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              mini: true,
              onPressed: () async {
                if(favoritecount%2==0){
                  controller.data.injectScriptCode(
                      """
                materials.wireframeAndModel.visible = false;
                      """); // wire가 생겨남
                }
                else
                  {
                    controller.data.injectScriptCode(
                        """
                materials.wireframeAndModel.visible = true;
                        """); // wire가 없어짐
                  }
                favoritecount++;

              },
              child: const Icon(Icons.refresh),
            );
          }
          return Container();
        });
  }
  Widget downButton()
  {
    return FutureBuilder<InAppWebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<InAppWebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              mini: true,
              onPressed: () async {
                InAppWebViewController controlls;
                if(downcount%2==0){
                  controller.data.injectScriptCode(
                      """
                      mod.material = materials.phongMaterial;
                      """); // d
                }
                else
                {
                  controller.data.injectScriptCode(
                      """
                      mod.material = originalMat;
                      """); // d
                }
                downcount++;
              },
              child: const Icon(Icons.keyboard_arrow_down),
            );
          }
          return Container();
        });
  }
  Widget upButton()
  {
    return FutureBuilder<InAppWebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<InAppWebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              mini: true,
              onPressed: () async {
                if(upcount%2==0){
                  controller.data.injectScriptCode(
                      """
                axis_view.visible = true;
                      """); // d
                }
                else
                {
                  controller.data.injectScriptCode(
                      """
                axis_view.visible = false;
                        """); // d
                }
                upcount++;
              },
              child: const Icon(Icons.keyboard_arrow_up),
            );
          }
          return Container();
        });
  }
  Widget leftButton()
  {
    return FutureBuilder<InAppWebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<InAppWebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              mini: true,
              onPressed: () async {
                if(leftcount%2==0){
                  controller.data.injectScriptCode(
                      """
                gridHelper.visible = true;
                      """); // d
                }
                else
                {
                  controller.data.injectScriptCode(
                      """
                gridHelper.visible = false;
                        """); // d
                }
                leftcount++;
              },
              child: const Icon(Icons.keyboard_arrow_left),
            );
          }
          return Container();
        });
  }
  Widget rightButton()
  {
    return FutureBuilder<InAppWebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<InAppWebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
              mini: true,
              onPressed: () async {
                if(rightcount%2==0){
                  controller.data.injectScriptCode(
                      """
                outlinePass.enabled = true;
                      """); // d
                }
                else
                {
                  controller.data.injectScriptCode(
                      """
                outlinePass.enabled = false;
                        """); // d
                }
                rightcount++;
              },
              child: const Icon(Icons.keyboard_arrow_right),
            );
          }
          return Container();
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startVerticalDrag(details) {
    // Screen position of pointer when drag begins
    initialPositionY = details.globalPosition.dy;
    initialPositionX = details.globalPosition.dx;
  }
  void _whileVerticalDrag(details) {
    // Gets current timestamp and position of the drag event
    currentPositionY = details.globalPosition.dy;
    currentPositionX = details.globalPosition.dx;
    // Distance pointer has travelled since drag began
    positionYDelta = currentPositionY - initialPositionY;
    positionXDelta = currentPositionX - initialPositionX;
    print("X : $positionXDelta, Y : $positionYDelta");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
//        onVerticalDragStart: (details) => _startVerticalDrag(details),
//        onVerticalDragUpdate: (details) => _whileVerticalDrag(details),
        child: MaterialApp(
          home: Scaffold(
            body:
            Container(
//              margin: const EdgeInsets.all(10.0),
//              decoration: BoxDecoration(
//                  border: Border.all(color: Colors.blueAccent)
//              ),
              child: InAppWebView(
                initialFile: "assets/index.html",
//                initialUrl: "http://10.100.82.65/viewer/",
                initialHeaders: {
                },
                initialOptions: {
                },
                onWebViewCreated: (InAppWebViewController controller) {
                  _controller.complete(controller);
                  webView = controller;
                  controller.loadFile('assets/index.html');
//                  controller.loadUrl('http://10.100.82.65/viewer/');
                },
                onLoadStop: (InAppWebViewController controller, String url) {
//                      controller.injectScriptCode("""
//                            window.flutter_inappbrowser.callHandler('test', 'Text from Javascript').then(function(result) {
//                              console.log(result);
//                              alert(result);
//                            });
//                            """);hj
                },
                onLoadStart: (InAppWebViewController controller, String url) {
                  print("started $url");
                  setState(() {
                    this.url = url;
//                  controller.addJavaScriptHandler('test',(arguments) async {print("test");print(arguments);});
                  });
                },
                onProgressChanged: (InAppWebViewController controller,
                    int progress) {
                  setState(() {
                    this.progress = progress / 100;
                  });
                },
              ),
            ),
            floatingActionButton: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                favoriteButton(),
                leftButton(),
                rightButton(),
                upButton(),
                downButton(),
              ],
            ),
          ),
        )
    );

  }
}