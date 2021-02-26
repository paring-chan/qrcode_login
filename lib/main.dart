import 'package:flutter/material.dart';
import 'package:qrlogin/LoginProfile.dart';
import 'package:qrlogin/ProfileListView.dart';

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
          child: ProfileListView()
        ),
      ),
    );
  }
}
