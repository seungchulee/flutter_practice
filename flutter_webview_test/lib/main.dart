import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var title = 'Webview Demo';
    return new MaterialApp(
      title: title,
      routes: {
        '/widget': (_) => new WebviewScaffold(
          url: "https://www.google.com",
          appBar: new AppBar(
            title: const Text('Widget Webview'),
          ),
          withZoom: false,
          withLocalStorage: true,
        )
      },
      home: new MyAppHomePage(),
    );
  }
}

class MyAppHomePage extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyAppHomePage> {
  void _opennewpage() {
    Navigator.of(context).pushNamed('/widget');
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Browser test"),
        ),
        body: new Center(
          child: new RaisedButton(
              child: Text('Open Link'),
              onPressed: () {
                _opennewpage();
              }
          ) ,
        )
    );
  }

}