import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_inappbrowser/flutter_inappbrowser.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class albumpage extends StatefulWidget{
  @override
  _albumstate createState() => new _albumstate();
}
class _albumstate extends State<albumpage>
{
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  @override
  void initState() {
    super.initState();
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 300,
          height: 300,
        );
      }),
    );
  }

  Future<void> deleteAssets() async {
    await MultiImagePicker.deleteImages(assets: images);
    setState(() {
      images = List<Asset>();
    });
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
          maxImages: 300,
          enableCamera: true,
          selectedAssets: images,
          cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
          materialOptions: MaterialOptions(
            actionBarColor: "#abcdef",
            actionBarTitle: "Example App",
            allViewTitle: "All Photos",
            useDetailsView: false,
            selectCircleStrokeColor: "#000000",
          ));
    } on PlatformException catch (e) {
      error = e.message;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('album'),
        ),
        body: Column(
          children: <Widget>[
            Center(child: Text('Error: $_error')),
            Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text("Pick images"),
                      onPressed: loadAssets,
                    ),
                    RaisedButton(
                        child: Text("Next"),
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => webviewpage()),
                          );
                        }
                    )
                  ]
              ),
            ),
            images.length > 0
                ? RaisedButton(
              child: Text("Delete images"),
              onPressed: deleteAssets,
            )
                : Container(),
            Expanded(
              child: buildGridView(),
            )
          ],
        ),
      ),
    );
  }
//  @override
//  Widget build(BuildContext context)
//  {
//    return Scaffold(
//        appBar: AppBar(
//          title: Text('photos'),
//        ),
//        body: Row(
//          children: <Widget>[
//            RaisedButton(
//                child: Text("Next"),
//                onPressed: () {
//                  Navigator.pushReplacement(
//                    context,
//                    MaterialPageRoute(builder: (context) => webviewpage()),
//                  );
//                }
//            )
//          ],
//        )
//    );
//  }
}

class CameraExample extends StatefulWidget {
  @override
  _CameraExampleState createState() {
    return _CameraExampleState();
  }
}

class _CameraExampleState extends State {
  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;
  bool _allowWriteFile = false;
  final GlobalKey _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Get the list of available cameras.
    // Then set the first camera as selected.
    availableCameras()
        .then((availableCameras) {
      cameras = availableCameras;

      if (cameras.length > 0) {
        setState(() {
          selectedCameraIdx = 0;
        });

        _onCameraSwitched(cameras[selectedCameraIdx]).then((void v) {});
      }
    })
        .catchError((err) {
      print('Error: $err.code\nError Message: $err.message');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      key: _scaffoldKey,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: _cameraPreviewWidget(),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(
                  color: Colors.grey,
                  width: 3.0,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _cameraTogglesRowWidget(),
                _captureControlRowWidget(),
                _thumbnailWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Display 'Loading' text when the camera is still loading.
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }

  /// Display the thumbnail of the captured image
  Widget _thumbnailWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.centerRight,
        child: imagePath == null
            ? SizedBox()
            : SizedBox(
          child: Image.file(File(imagePath)),
          width: 64.0,
          height: 64.0,
        ),
      ),
    );
  }

  /// Display the control bar with buttons to take pictures
  Widget _captureControlRowWidget() {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              icon: const Icon(Icons.camera_alt),
              color: Colors.blue,
              onPressed: controller != null &&
                  controller.value.isInitialized
                  ? _onCapturePressed
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.keyboard_arrow_right),
              color: Colors.red,
              onPressed:() {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => albumpage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    if (cameras == null) {
      return Row();
    }

    CameraDescription selectedCamera = cameras[selectedCameraIdx];
    CameraLensDirection lensDirection = selectedCamera.lensDirection;

    return Expanded(
      child: Align(
        alignment: Alignment.centerLeft,
        child: FlatButton.icon(
            onPressed: _onSwitchCamera,
            icon: Icon(
                _getCameraLensIcon(lensDirection)
            ),
            label: Text("${lensDirection.toString()
                .substring(lensDirection.toString().indexOf('.')+1)}")
        ),
      ),
    );
  }

  IconData _getCameraLensIcon(CameraLensDirection direction) {
    switch (direction) {
      case CameraLensDirection.back:
        return Icons.camera_rear;
      case CameraLensDirection.front:
        return Icons.camera_front;
      case CameraLensDirection.external:
        return Icons.camera;
      default:
        return Icons.device_unknown;
    }
  }


  Future _onCameraSwitched(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        Fluttertoast.showToast(
            msg: 'Camera error ${controller.value.errorDescription}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
      _showCameraException(e);
    }

    if (mounted) {
      setState(() {});
    }
  }

  void _onSwitchCamera() {
    selectedCameraIdx = selectedCameraIdx < cameras.length - 1
        ? selectedCameraIdx + 1
        : 0;
    CameraDescription selectedCamera = cameras[selectedCameraIdx];

    _onCameraSwitched(selectedCamera);

    setState(() {
      selectedCameraIdx = selectedCameraIdx;
    });
  }

  Future<String> _takePicture() async {
    if (!controller.value.isInitialized) {
      Fluttertoast.showToast(
          msg: 'Please wait',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white
      );

      return null;
    }




    final Directory appDirectory = await getExternalStorageDirectory();
//    final String pictureDirectory = '${appDirectory.path}/Pictures';
     final String pictureDirectory = '${appDirectory.path}';
    await Directory(pictureDirectory).create(recursive: true);
    final String currentTime = DateTime.now().millisecondsSinceEpoch.toString();
//    final String filePath = '$pictureDirectory/${currentTime}.jpg';
    final String filePath = '$pictureDirectory/../../../../Pictures/${currentTime}.jpg';

//    print(pictureDirectory);
    print(filePath);

    // Do nothing if a capture is on progress
    if (controller.value.isTakingPicture) {
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }

    return filePath;
  }

  void _onCapturePressed() {
    _takePicture().then((String filePath) {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });

        if (filePath != null) {
          Fluttertoast.showToast(
              msg: 'Picture saved to $filePath',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey,
              textColor: Colors.white
          );
        }
      }
    });
  }

  void _showCameraException(CameraException e) {
    String errorText = 'Error: ${e.code}\nError Message: ${e.description}';
    print(errorText);

    Fluttertoast.showToast(
        msg: 'Error: ${e.code}\n${e.description}',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white
    );
  }
}
class webviewpage extends StatefulWidget{
  @override
  _webstate createState() => new _webstate();
}
class _webstate extends State<webviewpage>
{
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
                materials.wireframeAndModel.visible = true;
                      """); // wire가 생겨남
                }
                else
                {
                  controller.data.injectScriptCode(
                      """
                materials.wireframeAndModel.visible = false;
                        """); // wire가 없어짐
                }
                favoritecount++;

              },
              child: const Icon(Icons.timeline),
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
                if(downcount%2==0){
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
              child: const Icon(Icons.grid_on),
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
              child: const Icon(Icons.highlight),
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
    return GestureDetector(

        child: MaterialApp(
          home: Scaffold(
            body:
            Container(
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
                //downButton(),
              ],
            ),
          ),
        )
    );

  }
}
class CameraApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CameraExample(),
    );
  }
}

Future main() async {

  runApp(CameraApp());
}
