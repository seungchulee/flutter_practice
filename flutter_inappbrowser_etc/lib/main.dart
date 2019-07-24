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

  Widget favoriteButton() {
    return FutureBuilder<InAppWebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<InAppWebViewController> controller) {
          if (controller.hasData) {
            return FloatingActionButton(
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
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Inline WebView example app'),
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text("CURRENT URL\n${ (url.length > 50) ? url.substring(0, 50) + "..." : url }"),
              ),
              (progress != 1.0) ? LinearProgressIndicator(value: progress) : null,
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent)
                  ),
                  child: InAppWebView(
                    // initialUrl: "assets/threejs.html",
                    initialHeaders: {
                    },
                    initialOptions: {
                      "useOnLoadResource": true,
                    },
                    onWebViewCreated: (InAppWebViewController controller) {
                      webView = controller;
                      controller.loadFile('assets/threejs.html');
                    },
                    onLoadStop:(InAppWebViewController controller, String url)
                      {
                        print("THIS");
//                        controller.injectScriptCode("""
//                            window.flutter_inappbrowser.callHandler('test', 'Text from Javascript').then(function(result) {
//                              console.log(result);
//                              alert(result);
//                            });
//                            """);
                      },
                    onLoadStart: (InAppWebViewController controller, String url) {
                      print("started $url");
                      setState((){
                        this.url = url;
//                        print("THAT");
//                        controller.addJavaScriptHandler('test',(arguments) async {print("test");print(arguments);});
                        });
                    },
                    onProgressChanged: (InAppWebViewController controller, int progress) {
                      setState(() {
                        this.progress = progress/100;
                      });
                    },
                  ),
                ),
              ),
                ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Icon(Icons.arrow_back),
                    onPressed: () {
                      if (webView != null) {
                        webView.goBack();
                      }
                    },
                  ),
                  RaisedButton(
                    child: Icon(Icons.arrow_forward),
                    onPressed: () {
                      if (webView != null) {
                        webView.goForward();
                      }
                    },
                  ),
                  RaisedButton(
                    child: Icon(Icons.refresh),
                    onPressed: () {
                      if (webView != null) {
                        webView.reload();
                      }
                    },
                  ),

                ],
              ),
            ].where((Object o) => o != null).toList(),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mail),
              title: Text('Item 2'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Item 3')
            )
          ],
        ),
      floatingActionButton: favoriteButton(),
      ),
    );
  }
}
//import 'package:flutter/material.dart';
//import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
//
//class MyInAppBrowser extends InAppBrowser {
//
//  @override
//  void onBrowserCreated() async {
//    print("\n\nBrowser Ready!\n\n");
//  }
//
//  @override
//  void onLoadStart(String url) {
//    print("\n\nStarted $url\n\n");
//  }
//
//  @override
//  Future onLoadStop(String url) async {
//    print("\n\nStopped $url\n\n");
//
//    // call a javascript message handler
//    await this.webViewController.injectScriptCode("window.flutter_inappbrowser.callHandler('handlerNameTest', 1, 5,'string', {'key': 5}, [4,6,8]);");
//
//    // print body html
//    print(await this.webViewController.injectScriptCode("document.body.innerHTML"));
//
//    // console messages
//    await this.webViewController.injectScriptCode("console.log({'testObject': 5});"); // the message will be: [object Object]
//    await this.webViewController.injectScriptCode("console.log('testObjectStringify', JSON.stringify({'testObject': 5}));"); // the message will be: testObjectStringify {"testObject": 5}
//    await this.webViewController.injectScriptCode("console.error('testError', false);"); // the message will be: testError false
//
//    // add jquery library and custom javascript
//    await this.webViewController.injectScriptFile("https://code.jquery.com/jquery-3.3.1.min.js");
//    this.webViewController.injectScriptCode("""
//      \$( "body" ).html( "Next Step..." )
//    """);
//
//    // add custom css
//    this.webViewController.injectStyleCode("""
//    body {
//      background-color: #3c3c3c !important;
//    }
//    """);
//    this.webViewController.injectStyleFile("https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css");
//  }
//
//  @override
//  void onLoadError(String url, int code, String message) {
//    print("\n\nCan't load $url.. Error: $message\n\n");
//  }
//
//  @override
//  void onExit() {
//    print("\n\nBrowser closed!\n\n");
//  }
//
//  @override
//  void shouldOverrideUrlLoading(String url) {
//    print("\n\n override $url\n\n");
//    this.webViewController.loadUrl(url);
//  }
//
//  @override
//  void onLoadResource(WebResourceResponse response, WebResourceRequest request) {
//    print("Started at: " + response.startTime.toString() + "ms ---> duration: " + response.duration.toString() + "ms " + response.url);
//  }
//
//  @override
//  void onConsoleMessage(ConsoleMessage consoleMessage) {
//    print("""
//    console output:
//      sourceURL: ${consoleMessage.sourceURL}
//      lineNumber: ${consoleMessage.lineNumber}
//      message: ${consoleMessage.message}
//      messageLevel: ${consoleMessage.messageLevel}
//    """);
//  }
//
//}
//
//MyInAppBrowser inAppBrowser = new MyInAppBrowser();
//
//void main() => runApp(new MyApp());
//
//class MyApp extends StatefulWidget {
//  @override
//  _MyAppState createState() => new _MyAppState();
//}
//
//class _MyAppState extends State<MyApp> {
//
//  @override
//  void initState() {
//    super.initState();
//
//    // listen for post messages coming from the JavaScript side
//    inAppBrowser.webViewController.addJavaScriptHandler("handlerNameTest", (arguments) async {
//      print("handlerNameTest arguments");
//      print(arguments); // it prints: [1, 5, string, {key: 5}, [4, 6, 8]]
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      home: new Scaffold(
//        appBar: new AppBar(
//          title: const Text('Flutter InAppBrowser Plugin example app'),
//        ),
//        body: new Center(
//          child: new RaisedButton(onPressed: () async {
//            await inAppBrowser.open(url: "https://flutter.io/", options: {
//              "useShouldOverrideUrlLoading": true,
//              "useOnLoadResource": true
//            });
//          },
//              child: Text("Open InAppBrowser")
//          ),
//        ),
//      ),
//    );
//  }
//}