import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class ResetPage extends StatefulWidget{
  static String tag = 'reset-page';
  @override
  _ResetPageState createState() => new _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  static final TextEditingController _email = new TextEditingController();
  String get emailText => _email.text;

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
      controller: _email,
      autofocus: false,
      decoration: new InputDecoration(
          hintText: 'Email',
          contentPadding: new EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(32.0)
          )
      ),
    );

    void alertEmail() {
      AlertDialog alert = new AlertDialog(
        content: new Text(
          'Email erfolgreich gesendet',
          style:  new TextStyle(fontSize: 20.0),),
        actions: <Widget>[
          new FlatButton(onPressed: (){Navigator.pop(context);}, child: new Text('Ok')),
        ],
      );
      showDialog(context: context, child: alert);
    }

    void alertEmailError() {
      AlertDialog alert = new AlertDialog(
        content: new Text(
          'Email flasch! Nicht versendet!',
          style:  new TextStyle(fontSize: 20.0),),
        actions: <Widget>[
          new FlatButton(onPressed: (){Navigator.pop(context);}, child: new Text('Ok')),
        ],
      );
      showDialog(context: context, child: alert);
    }

    final forgotButton = new Padding(
        padding: new EdgeInsets.symmetric(vertical: 16.0),
        child: new Material(
          borderRadius: new BorderRadius.circular(30.0),
          shadowColor: Colors.lightBlueAccent.shade100,
          elevation: 5.0,
          child: new MaterialButton(
            minWidth: 140.0,
            height: 42.0,
            onPressed: () async {
              try{await _auth.sendPasswordResetEmail(email: emailText); alertEmail();}
              catch(e){alertEmailError();}
            },
            color: Colors.lightBlueAccent,
            child: new Text(
                'Passwort zurücksetzten', style: new TextStyle(color: Colors.white)),
          ),
        )
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: new ListView(
          shrinkWrap: true,
          padding: new EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            new SizedBox(height: 48.0),
            email,
            new SizedBox(height: 14.0),
            forgotButton
          ],
        ),
      ),
    );
  }
}