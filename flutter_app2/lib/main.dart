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
                controller.data.injectScriptCode(
                    """cube.material.color.setHex('0x' + Math.floor(Math.random() * 16777215).toString(16));""");
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
                controller.data.injectScriptCode(
                    """cube.rotation.x+=0.1""");
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
                controller.data.injectScriptCode(
                    """cube.rotation.x-=0.1""");
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
                controller.data.injectScriptCode(
                    """cube.rotation.y-=0.1""");
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
                controller.data.injectScriptCode(
                    """cube.rotation.y+=0.1""");
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
                initialHeaders: {
                },
                initialOptions: {
                },
                onWebViewCreated: (InAppWebViewController controller) {
                  _controller.complete(controller);
                  webView = controller;
                  controller.loadFile('assets/index.html');
//                  controller.loadUrl('https://www.google.com');
                },
                onLoadStop: (InAppWebViewController controller, String url) {
//                      controller.injectScriptCode("""
//                            window.flutter_inappbrowser.callHandler('test', 'Text from Javascript').then(function(result) {
//                              console.log(result);
//                              alert(result);
//                            });
//                            """);
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
//            floatingActionButton: Row(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                favoriteButton(),
//                downButton(),
//                leftButton(),
//                upButton(),
//                rightButton(),
//              ],
//            ),
          ),
        )
    );

  }
}