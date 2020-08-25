import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
void main() => runApp(
    MaterialApp(
      home: barcodeApp(),
    )
);

class barcodeApp extends StatefulWidget {
  static const String id = 'main_screen';
  @override
  _barcodeState createState() => _barcodeState();
}

class _barcodeState extends State<barcodeApp> {
  String _scanBarcode = 'Unknown';
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;
  void getCurrentUser() async{
    try{
      final User =  await _auth.currentUser();
      if(User == null){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuthApp()),
        );
      }
    }catch(e){
      print(e);
    }
  }
  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
        "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: const Text('Barcode scan')),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            onPressed: () => scanBarcodeNormal(),
                            child: Text("Start barcode scan")),
                        RaisedButton(
                            onPressed: () => scanQR(),
                            child: Text("Start QR scan")),
                        RaisedButton(
                            onPressed: () => startBarcodeScanStream(),
                            child: Text("Start barcode scan stream")),
                        Text('Scan result : $_scanBarcode\n',
                            style: TextStyle(fontSize: 20)),
                      ]));
            })));
  }
}
