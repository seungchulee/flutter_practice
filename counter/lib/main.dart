import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body:
          countersWidget(),
      ),
    );
  }
}

class countersWidget extends StatefulWidget{
  @override
  _countersWidgetState createState() => _countersWidgetState();
}

class _countersWidgetState extends State<countersWidget>{
  int count=0;

  void _increase(){
    setState((){
      count++;
    });
  }
  void _decrease(){
    setState((){
      count--;
    });
  }
  void _clear(){
    setState((){
      count=0;
    });
  }

  Widget _buildBody(){
    return Scaffold(
        body: Text('$count'),
      );
  }

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title:'Counters',
      home:Scaffold(
        appBar: AppBar(
          title: Text("my counters"),
        ),
        body:
        Container(
          child:ListView(
            children:<Widget>[
          RichText(
            textAlign:TextAlign.center,
          text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: '$count', style: TextStyle(fontSize:150.0,color:Colors.indigoAccent)),
            ],
          ),
        ),
//              Text('$count', style:TextStyle(fontSize:250.0,color:Colors.indigoAccent)),
              Row(
                mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                children:<Widget>[
//                  RaisedButton(
//                      child:IconButton(icon:Icon(Icons.remove),onPressed:_decrease, color:Colors.white),
////                    color:Colors.red,splashColor:Colors.grey,
//                  ),
                  FloatingActionButton.extended(
                    icon:Icon(Icons.remove),
                    label:Text("빼기"),
                    onPressed:() => _decrease(),
                    backgroundColor: Colors.red,
                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(16.0))),
                  ),
                  FloatingActionButton.extended(
                    icon:Icon(Icons.add, color: Colors.yellow,),
                    label:Text("더하기"),
                    onPressed:() => _increase(),
                    shape:RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(16.0))),
                  ),
                ]
              ),
              Padding(padding:EdgeInsets.all(50.0),child:InkWell(child:Text('CLEAR', textAlign:TextAlign.center,
                  style:TextStyle(height:2,fontSize:24,)),onTap:() => _clear(),),),

            ]
          )
        )
      )
    );
  }

}