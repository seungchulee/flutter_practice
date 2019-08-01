import 'package:flutter/material.dart';

void main() => runApp(reportview());

class Welcomepage extends StatefulWidget{
  @override
  _Welcomestate createState() => _Welcomestate();
}
class _Welcomestate extends State<Welcomepage> {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home:Scaffold(
          appBar:AppBar(
            backgroundColor: Colors.transparent,
            elevation:0.0,
          ),
          backgroundColor: Colors.grey,
         drawer: Drawer(
           child:ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                accountName: Text("Ashish Rawat"),
                accountEmail: Text("ashishrawat2911@gmail.com"),
                currentAccountPicture: CircleAvatar(
                  backgroundColor:
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? Colors.blue
                      : Colors.white,
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 40.0),
                  ),
                ),
              ),
              ListTile(
                title:Text("마이 리포트"),
              ),
              ListTile(
                title:Text("마이페이지"),
              ),
              ListTile(
                title:Text("뉴스"),
              ),

              ListTile(
                title:Text("자신감샵"),
              ),
              ListTile(
                title:Text("자랑하기"),
              ),
              ListTile(
                title:Text("설정"),
              ),
            ],
           )
         ),
         body:
             Container(
               child: Stack(
                 children: <Widget>[
                   Positioned(
                     child:Align(
                       alignment: FractionalOffset.bottomCenter,
                         child: Container(
                           color: Colors.white,
                           height: 370.0,
                         )
                     )
                   ),

                   Container(
                     margin:EdgeInsets.symmetric(vertical:220.0,horizontal: 150.0),
                     width: 120.0,
                     height: 120.0,
                     decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       color: Colors.orange,
                     ),
                   ),

                   Positioned(
                     child: Padding(
                         padding: EdgeInsets.symmetric(vertical: 260.0),
                         child: Align(
                           alignment:FractionalOffset.bottomCenter,
                           child: Container(
                               child: Text("Welcome, Guest!",
                                style:TextStyle(fontSize: 25.0)
                               )
                           ),
                         )
                     ),
                   ),
                   Positioned(
                     child:Padding(
                       padding:EdgeInsets.symmetric(vertical:200.0,horizontal:40.0),
                       child: Align(
                           alignment: FractionalOffset.bottomCenter,
                           child: Container(
                               child: Text(
                                   '''Weasel the jeeper goodness inconsiderately spelled so ubiquitous amused knitted and altruistic amiable far much toward.''',
                                   style:TextStyle(),
                                 textAlign: TextAlign.center,
                               )
                           )
                       )
                     ),
                   ),
                   Positioned(
                       child: Padding(
                         padding: EdgeInsets.all(100.0),
                         child: Align(
                           alignment: FractionalOffset.bottomCenter,
                           child: Container(
                                   child: ButtonTheme(
                                       minWidth:500.0,
                                       height:45.0,
                                       child:RaisedButton(
                                           child:Text('회원가입',style:TextStyle(color:Colors.white)),
                                           onPressed:(){
                                           }
                                       )
                                   ),
                           ),
                         ),
                       )
                   ),
                 ],
               )
             )

    )
    );
  }
}
class signup extends StatefulWidget{
  @override
  _signupstate createState() => _signupstate();
}
class _signupstate extends State<signup> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color.fromRGBO(255,255,255,0.95),
            appBar: AppBar(
              title: Text('Sign Up'),
            ),
            drawer: Drawer(
                child:ListView(
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      accountName: Text("Ashish Rawat"),
                      accountEmail: Text("ashishrawat2911@gmail.com"),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor:
                        Theme.of(context).platform == TargetPlatform.iOS
                            ? Colors.blue
                            : Colors.white,
                        child: Text(
                          "A",
                          style: TextStyle(fontSize: 40.0),
                        ),
                      ),
                    ),
                    ListTile(
                      title:Text("마이 리포트"),
                    ),
                    ListTile(
                      title:Text("마이페이지"),
                    ),
                    ListTile(
                      title:Text("뉴스"),
                    ),

                    ListTile(
                      title:Text("자신감샵"),
                    ),
                    ListTile(
                      title:Text("자랑하기"),
                    ),
                    ListTile(
                      title:Text("설정"),
                    ),
                  ],
                )
            ),
            body: ListView(
                children: [
                  Column(
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 30.0)),
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.orange,
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 50.0)),
                    Container(
                      color: Colors.white,
                      width: 380.0,
                      child: TextFormField(
                          decoration: InputDecoration(
                              labelText: '  Fullname'
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                      color: Colors.white,
                      width: 380.0,
                      child: TextFormField(
                          decoration: InputDecoration(
                              labelText: '  Username'
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                      color: Colors.white,
                      width: 380.0,
                      child: TextFormField(
                          decoration: InputDecoration(
                              labelText: '  Email'
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                      color: Colors.white,
                      width: 380.0,
                      child: TextFormField(
                          decoration: InputDecoration(
                              labelText: '  Password'
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                      color: Colors.white,
                      width: 380.0,
                      child: TextFormField(
                          decoration: InputDecoration(
                              labelText: '  Confirm Password'
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    ButtonTheme(
                        minWidth:380.0,
                        height:45.0,
                        child:RaisedButton(
                            child:Text('Button',style:TextStyle(color:Colors.white)),
                            onPressed:(){
                            }
                        )
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Already have account?  '),
                        InkWell(
                            child:Text('Sign In'),
                            onTap:() {
                            }
                        )
                      ],
                    )
                  ],

                )
                ]
            )
        )
    );

  }
}
class signin extends StatefulWidget{
  @override
  _signinstate createState() => _signinstate();
}
class _signinstate extends State<signin>
{
  bool _value1 = false;
  void _value1Changed(bool value) => setState(() => _value1 = value);
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home:Scaffold(
        backgroundColor: Colors.grey,
        appBar:AppBar(
          title:Text('Sign In'),
        ),
          drawer: Drawer(
              child:ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    accountName: Text("Ashish Rawat"),
                    accountEmail: Text("ashishrawat2911@gmail.com"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                      child: Text(
                        "A",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                  ListTile(
                    title:Text("마이 리포트"),
                  ),
                  ListTile(
                    title:Text("마이페이지"),
                  ),
                  ListTile(
                    title:Text("뉴스"),
                  ),

                  ListTile(
                    title:Text("자신감샵"),
                  ),
                  ListTile(
                    title:Text("자랑하기"),
                  ),
                  ListTile(
                    title:Text("설정"),
                  ),
                ],
              )
          ),
        body:Stack(
          children: <Widget>[
            Positioned(
              child:Align(
                  alignment: FractionalOffset.bottomCenter,
                  child:Container(
                    height:430.0,
                  decoration: BoxDecoration(
                    color:Color.fromRGBO(255,255,255,0.8),
                  ),
                )
              )
            ),
            Positioned(
              child:Padding(
                  padding: EdgeInsets.symmetric(vertical: 80.0,horizontal: 10.0),
                  child:Align(
                  alignment:FractionalOffset.bottomCenter,
                    child:Container(
                      height:335.0,
                      decoration: BoxDecoration(
                        color:Colors.white,
                      ),
                  )
              )
            )
            ),
            Positioned(
              child:Align(
                alignment:Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 200.0)),
                    Container(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      width: 350.0,
                      child: TextFormField(
                          decoration: InputDecoration(
                              labelText: '  Username'
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Container(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                      width: 350.0,
                      child: TextFormField(
                          decoration: InputDecoration(
                              labelText: '  Password'
                          )
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Checkbox(value: _value1, onChanged: _value1Changed),
                        Text('Remember me'),
                        Container(
                            alignment: Alignment.centerRight,
                            child:
                            InkWell(
                                child: Text("    Forgot Password"),
                                onTap: () {}
                            )
                        )
                      ],
                    ),
                    ButtonTheme(
                      minWidth:350.0,
                      height:45.0,
                      child:RaisedButton(
                        child:Text('Button',style:TextStyle(color:Colors.white)),
                        onPressed:(){
                        }
                      )
                    ),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    ButtonTheme(
                        minWidth:350.0,
                        height:45.0,
                        child:RaisedButton(
                            child:Text('Button',style:TextStyle(color:Colors.white)),
                            onPressed:(){
                            }
                        )
                    ),
                    Padding(padding: EdgeInsets.only(top: 60.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Don't have an account?"),
                        InkWell(
                          child: Text(" Sign Up"),
                          onTap: () {

                          },
                        )
                      ],
                    )

                  ],
                ),
              ),
            ),
          ],
        )





      )
    );
  }
}

class forgotpassword extends StatefulWidget{
  @override
  _forgotstate createState() => _forgotstate();
}
class _forgotstate extends State<forgotpassword>
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          backgroundColor: Color.fromRGBO(255,255,255,0.95),
            appBar: AppBar(
              title: Text('Forgot Password'),
            ),
            body:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Reset your Password',style: TextStyle(fontSize: 24),),
                Padding(padding: EdgeInsets.only(top: 25.0)),
                Container(
                  child:Text(
                    'Weasel the jeeper goodness inconsiderately spelled so ubiquitous amused knitted and altruistic amiable far much toward.',
                    textAlign: TextAlign.center,
                  ),
                  margin:EdgeInsets.symmetric(horizontal:38.0),
                ),
                Padding(padding: EdgeInsets.only(top: 30.0)),
                Container(
                  color: Colors.white,
                  width: 380.0,
                  child: TextFormField(
                      decoration: InputDecoration(
                          labelText: '  Email'
                      )
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                ButtonTheme(
                    minWidth: 370.0,
                    height: 45.0,
                    child: RaisedButton(
                        child: Text('Button',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {}
                    )
                ),
              ],
            )

        )
    );
  }
}

class userinfo extends StatefulWidget{
  @override
  _userstate createState() => _userstate();
}
class _userstate extends State<userinfo>{

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home:Scaffold(
        appBar:AppBar(
          title:Text("사용자정보"),
        ),
          drawer: Drawer(
              child:ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    accountName: Text("Ashish Rawat"),
                    accountEmail: Text("ashishrawat2911@gmail.com"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                      child: Text(
                        "A",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                  ListTile(
                    title:Text("마이 리포트"),
                  ),
                  ListTile(
                    title:Text("마이페이지"),
                  ),
                  ListTile(
                    title:Text("뉴스"),
                  ),

                  ListTile(
                    title:Text("자신감샵"),
                  ),
                  ListTile(
                    title:Text("자랑하기"),
                  ),
                  ListTile(
                    title:Text("설정"),
                  ),
                ],
              )
          ),
        body:Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: <Widget>[
                Container(
                  color: Colors.white,
                  width: 180.0,
                  child: TextFormField(
                      decoration: InputDecoration(
                          labelText: '  이름'
                      )
                  ),
                ),

                Container(
                  color: Colors.white,
                  width: 180.0,
                  child: TextFormField(
                      decoration: InputDecoration(
                          labelText: '  성'
                      )
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Container(
              color: Colors.white,
              width: 380.0,
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: '  생년월일'
                  )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Container(
              color: Colors.white,
              width: 380.0,
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: '  키'
                  )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Container(
              color: Colors.white,
              width: 380.0,
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: '  몸무게'
                  )
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 20.0)),
            Container(
              color: Colors.white,
              width: 380.0,
              child: TextFormField(
                  decoration: InputDecoration(
                      labelText: '  언더바스트'
                  )
              ),
            ),
          ],
        )
      )
    );
  }
}

class reportlist extends StatefulWidget{
  @override
  _reportstate createState() => _reportstate();
}
class _reportstate extends State<reportlist>
{
  @override 
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home:Scaffold(
        appBar:AppBar(

        ),
        drawer: Drawer(
            child:ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.grey,
                  ),
                  accountName: Text("Ashish Rawat"),
                  accountEmail: Text("ashishrawat2911@gmail.com"),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                    child: Text(
                      "A",
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
                ListTile(
                  title:Text("마이 리포트"),
                ),
                ListTile(
                  title:Text("마이페이지"),
                ),
                ListTile(
                  title:Text("뉴스"),
                ),

                ListTile(
                  title:Text("자신감샵"),
                ),
                ListTile(
                  title:Text("자랑하기"),
                ),
                ListTile(
                  title:Text("설정"),
                ),
              ],
            )
        ),
      )
    );
  }
}


class reportview extends StatefulWidget{
  @override
  _reportviewstate createState() => _reportviewstate();
}
class _reportviewstate extends State<reportview>
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
        home:Scaffold(
          appBar:AppBar(

          ),
          drawer: Drawer(
              child:ListView(
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                    accountName: Text("Ashish Rawat"),
                    accountEmail: Text("ashishrawat2911@gmail.com"),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor:
                      Theme.of(context).platform == TargetPlatform.iOS
                          ? Colors.blue
                          : Colors.white,
                      child: Text(
                        "A",
                        style: TextStyle(fontSize: 40.0),
                      ),
                    ),
                  ),
                  ListTile(
                    title:Text("마이 리포트"),
                  ),
                  ListTile(
                    title:Text("마이페이지"),
                  ),
                  ListTile(
                    title:Text("뉴스"),
                  ),

                  ListTile(
                    title:Text("자신감샵"),
                  ),
                  ListTile(
                    title:Text("자랑하기"),
                  ),
                  ListTile(
                    title:Text("설정"),
                  ),
                ],
              )
          ),
          body:Container(

            )
          ),
        );

  }
}
class Walkthrough extends StatefulWidget{
  @override
  _walkthrough createState() => _walkthrough();
}
class _walkthrough extends State<Walkthrough>
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home:Scaffold(
        body:Center(
          child:Column(
            children: <Widget>[
              FloatingActionButton(
                child:Text("A"),
                onPressed:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => camerapreview()),
                  );
                }
              )
            ],
          )
        )
      )
    );
  }
}
class camerapreview extends StatefulWidget{
  @override
  _camerastate createState() => _camerastate();
}
class _camerastate extends State<camerapreview>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar:AppBar(
        title:Text("S"),
      )
    );
  }
}