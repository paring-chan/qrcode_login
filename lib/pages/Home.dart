import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRCODE LOGIN'),
      ),
      body: Center(
          child: Column(
        children: [
          OutlinedButton(onPressed: () async {
            if (await Permission.camera.request().isGranted) {
              String result = await scanner.scan();
              var res = json.decode(result);
              var pref = await SharedPreferences.getInstance();
            } else {
              ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(content: Text('카메라 사용 권한을 허용해주세요.')));
            }
          }, child: Text('계정 추가하기'))
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      )),
    );
  }
}
