import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharezone_login_test/login_page.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    final logo = new Hero(
        tag: 'hero',
        child: new Padding(
          padding: new EdgeInsets.all(16.0),
          child: new CircleAvatar(
            radius: 72.0,
            backgroundColor: Colors.transparent,
            backgroundImage: new AssetImage('assets/logo.jpeg'),
          ),
        ),
    );

    final welcome = new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Text(
        'Willkommen User!',
        style: new TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final lorem = new Padding(
      padding: new EdgeInsets.all(8.0),
      child: new Text(
        'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.',
        style: new TextStyle(fontSize: 16.0, color: Colors.white),
      ),
    );

    final logoutButton = new Padding(
        padding: new EdgeInsets.symmetric(vertical: 16.0),
        child: new Material(
          borderRadius: new BorderRadius.circular(30.0),
          shadowColor: Colors.lightBlueAccent.shade100,
          elevation: 5.0,
          child: new MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: () async {
              await _auth.signOut();
              Navigator.of(context).pushReplacementNamed(LoginPage.tag);
            },
            color: Colors.lightBlueAccent,
            child: new Text(
                'Logout', style: new TextStyle(color: Colors.white)),
          ),
        )
    );


    final body = new Container(
      width: MediaQuery.of(context).size.width,
      padding: new EdgeInsets.all(28.0),
      decoration: new BoxDecoration(
        gradient: new LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent
        ]),
      ),
      child: new Column(children: <Widget>[logo, welcome, lorem, logoutButton]
        ,)
    );

    return new Scaffold(
      body: body
    );
  }
}
