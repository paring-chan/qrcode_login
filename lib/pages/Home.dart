import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRCODE LOGIN'),
      ),
      body: Center(
          child: Column(
        children: [OutlinedButton(onPressed: () async {

        }, child: Text('계정 추가하기'))],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      )),
    );
  }
}
