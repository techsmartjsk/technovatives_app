import 'package:Technovatives/Screens/BarcodeScanner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() => runApp(
    MaterialApp(
      home:LoginApp(),
    )
);

class LoginApp extends StatefulWidget {
  static const String id = 'auth_screen';
  @override
  _LoginAppState createState() => _LoginAppState();
}

class _LoginAppState extends State<LoginApp> {
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
                    'Login'
                ),
                onPressed: () async{
                  try{
                    final newUser = await _auth.signInWithEmailAndPassword(email: email, password:password);
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
