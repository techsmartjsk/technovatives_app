import 'package:Technovatives/Screens/BarcodeScanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() => runApp(
    MaterialApp(
     home:AuthApp(),
    )
);

class AuthApp extends StatefulWidget {
  static const String id = 'auth_screen';
  @override
  _AuthAppState createState() => _AuthAppState();
}

class _AuthAppState extends State<AuthApp> {
  String email, password;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggendinuser;
  void getCurrentUser() async{
    try{
      final User = await _auth.currentUser();
      loggendinuser = User;
      if(User != null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => barcodeApp()),
        );
      }
    }catch(e){
      print(e);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
      padding: EdgeInsets.all(20.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
      TextField(
      cursorColor: Colors.blueAccent,
        onChanged: (value){
          email= value;
        },
      ),
        TextField(
          cursorColor: Colors.blueAccent,
          obscureText: true,
          onChanged: (value){
            password = value;
          },
        ),
        FlatButton(
          color: Colors.blue,
          child: Text(
              'Register'
          ),
          onPressed: () async{
            try{
              final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
              if(newUser != null){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>barcodeApp ()),
                );
              }
            }catch(e){
              print(e);
            }
          },
        )
        ],
      ),
      )
    );
  }
}
