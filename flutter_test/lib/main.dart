import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: testWidet() ,
        ),
      );
  }
}

class testWidet extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:Text('First Page'),
      ),
      body:Center(
        child:
          Column(
              mainAxisAlignment:MainAxisAlignment.center,
              children:[
                BackButton(),
                TabButton(),
                CountButton(),
                sqlButton(),
            ]
          )
      )
    );
  }
}
class sqlButton extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    return RaisedButton(
      child:Text("sqlbutton"),
      onPressed:(){
        Navigator.push(
            context,
            MaterialPageRoute(builder:(context) => sqlpage()),
        );
      }
    );
  }
}
class sqlpage extends StatefulWidget{
  @override
  _sqlpagestate createState() => _sqlpagestate();
}
class _sqlpagestate extends State<sqlpage>{
  @override
  Widget build(BuildContext context)
  {

  }
}
class BackButton extends StatelessWidget{

  @override
  Widget build(BuildContext context){
    return Column(
        mainAxisAlignment:MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
              child:Text("Go"),
              onPressed:(){
                _gootherpage(context);
              }
              ),
      ],
    );
  }
  _gootherpage(BuildContext context) async{
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => testWidets()),
    );

    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content:Text('you tap a back'),
          action:SnackBarAction(
            label:'back again',
            onPressed:(){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => testWidets()),
              );
            }
          )
        )
      );
  }
}
class TabButton extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    return RaisedButton(
        child:Text("photo test"),
        onPressed:(){
          Navigator.push(
            context,
            MaterialPageRoute(builder:(context) => tabpage()),
          );
        }
    );
  }
}
class tabpage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:DefaultTabController(
        length:5,
        child:Scaffold(
          appBar:AppBar(
            actions:<Widget>[
              IconButton(
                icon:Icon(Icons.arrow_back),
                onPressed:(){
                  Navigator.pop(context);
                }
              ),
            ],
            bottom:TabBar(
              tabs:[
                Tab(icon:Icon(Icons.insert_photo),text:'ph1'),
                Tab(icon:Icon(Icons.insert_photo),text:'ph2'),
                Tab(icon:Icon(Icons.insert_photo),text:'ph3'),
                Tab(icon:Icon(Icons.insert_photo),text:'ph4'),
                Tab(icon:Icon(Icons.insert_photo),text:'ph5'),
              ]
            ),
                title:Text('photos'),
          ),
          body:TabBarView(
            children:[
              Image.network('https://www.slh.com/globalassets/country-pages/hero-images/czechrepublic2.jpg'),
              Image.network('https://cdn.muenchen-p.de/.imaging/stk/responsive/galleryLarge/dms/sw/mde/frauenkirche-4000/document/frauenkirche-4000.jpg'),
              Image.network('https://gotrip.s3.amazonaws.com/storage/go_trip/product/id/b/6/5/5/3/5/e/b65535eaa77259bc0e8f6062c2951c99/10001/986aced165a56a93a803dfbe52882165.jpg'),
              Image.network('https://miro.medium.com/max/1200/1*ilC2Aqp5sZd1wi0CopD1Hw.png'),
              Image.network('https://www.dartlang.org/assets/shared/dart-logo-for-shares.png?2'),
            ]
          )
        )
      )
    );
  }
}
class testWidets extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Second Page'),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body:
        Center(
            child:
            RaisedButton(
                child:Text("Back"),
                onPressed:(){
                  Navigator.pop(context,'BACK');
                }
            )
        ),
    );
  }
}
class CountButton extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    return RaisedButton(
        child:Text("counter"),
        onPressed:(){
          Navigator.push(
            context,
            MaterialPageRoute(builder:(context) => countpage()),
          );
        }
    );
  }
}
class countpage extends StatefulWidget{
  @override
  _countpagestate createState() => _countpagestate();
}

class _countpagestate extends State<countpage> {
  int count = 0;

  void _increase(){
    setState((){
        count++;
      }
    );
  }
  void _decrease(){
    setState((){
        count--;
        if(count<0)
          count=0;
      }
    );
  }
  void _clear(){
    setState((){
        count=0;
      }
    );
  }
  Widget _clearwg()
  {
    return Container(
      decoration:BoxDecoration(
        color:Colors.black,
      ),
      child:
        Center(
          child:
            InkWell(
              child:Text('CLEAR',textAlign:TextAlign.center,
                style:TextStyle(fontSize:24,color:Colors.white)),
              onTap:() => _clear(),
            )
        )
    );
  }

  Widget _countText(){
    return Container(
        decoration:BoxDecoration(
          color:Colors.purple,
          gradient: new LinearGradient(
            colors: [Colors.red, Colors.cyan],
          ),
        ),
        child:
            Center(
              child:
              Text('$count', style:TextStyle(fontSize:150.0,color:Colors.greenAccent)),
            )
      );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Counters',
      home:Scaffold(
        appBar: AppBar(
          title: Text("counters"),
          actions:<Widget>[
            IconButton(
                icon:Icon(Icons.arrow_back),
                onPressed:(){
                  Navigator.pop(context);
                }
            ),
          ],
        ),
        body:ListView(
          children:<Widget>[
            _countText(),
            Padding(padding: EdgeInsets.only(top: 40.0)),
            Row(
              mainAxisAlignment : MainAxisAlignment.spaceEvenly,
              children:<Widget>[
                FloatingActionButton.extended(
                  heroTag: 'minus',
                  icon:Icon(Icons.remove),
                  label:Text("빼기"),
                  onPressed:() => _decrease(),
                  backgroundColor: Colors.red,
                  shape:RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(32.0))),
                ),
                FloatingActionButton.extended(
                  heroTag: "plus",
                  icon:Icon(Icons.add, color: Colors.yellow,),
                  label:Text("더하기"),
                  onPressed:() => _increase(),
                  shape:RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(16.0))),
                ),
              ]
            ),
            Padding(padding: EdgeInsets.only(top: 40.0)),
            _clearwg(),
          ]
        )
      )
    );
  }
}
