import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return MaterialApp(
      title: 'QRLogin',
      home: Scaffold(
        appBar: AppBar(
          title: Text('QRCODE LOGIN'),
        ),
        body: Center(
          child: Text('Hello, world!'),
        ),
      ),
    );
  }
}
