import 'dart:async';

import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:google_sign_in/google_sign_in.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future main()async {
  final FirebaseUser user = await _auth.currentUser();
  if(user == null) {
    runApp(new MyApp());
  }
  else if(user != null){
    runApp(new MyApp2());
  }
  print(user);
}

class MyApp extends StatelessWidget{
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => new LoginPage(),
    HomePage.tag: (context) => new HomePage(),
  };
    @override
    Widget build(BuildContext context) {
      return new MaterialApp(
          title: 'CodingBrain',
          debugShowCheckedModeBanner: false,
          theme: new ThemeData(
            primarySwatch: Colors.lightBlue,
            fontFamily: 'Nunito',
          ),
          home: new LoginPage(),
        routes: routes,
      );
    }
}

class MyApp2 extends StatelessWidget{
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => new LoginPage(),
    HomePage.tag: (context) => new HomePage(),
  };
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'CodingBrain',
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'Nunito',
      ),
      home: new HomePage(),
      routes: routes,
    );
  }
}
