import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'Screens/auth.dart';
import 'Screens/LoginApp.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() => runApp(
  MaterialApp(
    home: MyApp(),
  )
);

class MyApp extends StatefulWidget {
  static const String id = 'main_screen';
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _scanBarcode = 'Unknown';
  final _auth = FirebaseAuth.instance;

  void getCurrentUser(){
    // ignore: non_constant_identifier_names
    final User = _auth.currentUser;
    if(User == null){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AuthApp()),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Builder(builder: (BuildContext context) {
              return Scaffold(
                body: new Container(
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text('Technovatives',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold
                      )),
                      FlatButton(
                        color: Colors.blue,
                        child: Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 10.0,
                          ),
                        ),
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => LoginApp()));
                        },
                      ),
                      FlatButton(
                        child: Text(
                          'Register',
                          style: TextStyle(
                            fontSize: 10.0,
                          )
                        ),
                          onPressed: (){
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => AuthApp()));
                          },
                      ),
                    ],
                  )
                ),
              );
            })
        )
    );
  }
}
