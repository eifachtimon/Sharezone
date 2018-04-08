import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'reset_password.dart';
//import 'package:google_sign_in/google_sign_in.dart'; //Used in the future

final FirebaseAuth _auth = FirebaseAuth.instance;
//final GoogleSignIn _googleSignIn = new GoogleSignIn(); //Used in the future

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final TextEditingController _user = new TextEditingController();
  static final TextEditingController _pass = new TextEditingController();
  String get username => _user.text;
  String get passi => _pass.text;

  @override
  Widget build(BuildContext context) {
    final logo = new Hero(
      tag: 'hero',
      child: new CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 48.0,
          child: new Image.asset('assets/logo.jpeg')
      ),
    );
    final email = new TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: _user,
      autofocus: false,
      decoration: new InputDecoration(
          hintText: 'Email',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(32.0)
          )
      ),
    );

    final password = new TextFormField(
      autofocus: false,
      controller: _pass,
      obscureText: true,
      decoration: new InputDecoration(
          hintText: 'Passwort',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(32.0)
          )
      ),
    );

    void alertEmail() {
      AlertDialog alert = new AlertDialog(
        content: new Text(
          'Email oder Passwort sind falsch!',
          style:  new TextStyle(fontSize: 20.0),
        ),
        actions: <Widget>[
          new FlatButton(onPressed: (){
            Navigator.pop(context);},
            child: new Text('Ok')
          ),
        ],
      );
      showDialog(context: context, child: alert);
    }

    final loginButton = new Padding(
        padding: new EdgeInsets.symmetric(vertical: 16.0),
        child: new Material(
          borderRadius: new BorderRadius.circular(30.0),
          shadowColor: Colors.lightBlueAccent.shade100,
          elevation: 5.0,
          child: new MaterialButton(
            minWidth: 140.0,
            height: 42.0,
            onPressed: () async {
              try{
                await _auth.signInWithEmailAndPassword(email: username, password: passi);
                Navigator.of(context).pushReplacementNamed(HomePage.tag);
              }
              catch(e){
                alertEmail();
              }
            },
            color: Colors.lightBlueAccent,
            child: new Text(
                'Login',
                style: new TextStyle(color: Colors.white)
            ),
          ),
        )
    );

    void alterCreate() {
      AlertDialog alert = new AlertDialog(
        content: new Text(
          'Email/Passwort ist falsch oder Account existiert schon!',
          style:  new TextStyle(fontSize: 20.0),
        ),
          actions: <Widget>[
          new FlatButton(onPressed: (){
            Navigator.pop(context);},
            child: new Text('Ok')
          ),
        ],
      );
      showDialog(context: context, child: alert);
    }

    void alterCreateYep() {
      AlertDialog alert = new AlertDialog(
        content: new Text(
          'Account erfolgreich erstellt!',
          style:  new TextStyle(fontSize: 20.0),
        ),
        actions: <Widget>[
          new FlatButton(onPressed: (){
            Navigator.pop(context);},
            child: new Text('Ok')
          ),
        ],
      );
      showDialog(context: context, child: alert);
    }

    final createButton = new Padding(
        padding: new EdgeInsets.symmetric(vertical: 16.0),
        child: new Material(
          borderRadius: new BorderRadius.circular(30.0),
          shadowColor: Colors.lightBlueAccent.shade100,
          elevation: 5.0,
          child: new MaterialButton(
            minWidth: 140.0,
            height: 42.0,
            onPressed: () async {
              try{
                await _auth.createUserWithEmailAndPassword(email: username, password: passi);
                alterCreateYep();
              }
              catch(e){
                alterCreate();
              }
            },
            color: Colors.lightBlueAccent,
            child: new Text(
                'Account erstellen',
                style: new TextStyle(color: Colors.white)
            ),
          ),
        )
    );

    final forgotLable = new FlatButton(
      onPressed: () {
        Navigator.of(context).pushNamed(ResetPage.tag);
      },
      child: new Text(
          'Passwort zurücksetzten?',
          style: new TextStyle(color: Colors.black54)
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Container(
        alignment: Alignment.center,
        child: new ListView(
          shrinkWrap: true,
          padding: new EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            new SizedBox(height: 48.0),
            email,
            new SizedBox(height: 8.0),
            password,
            new SizedBox(height: 14.0),
            new Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>[loginButton,createButton]),
            forgotLable
          ],
        ),
      ),
    );
  }
}
