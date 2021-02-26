import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrlogin/db.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:sqflite/sqflite.dart';

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
              try {
                String result = await scanner.scan();
                var res = json.decode(result);
                var db = await DB.getDB();
                var data = await showDialog(context: ctx, builder: (context) {
                  return AlertDialog(
                    title: Text('계정 등록'),
                    content: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: '이메일'
                            ),
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: '비밀번호'
                            ),
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(onPressed: () {
                        Navigator.pop(context, "Cancel");
                      }, child: Text('취소')),
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: Text('저장'))
                    ],
                  );
                },barrierDismissible: false);
                if (data == 'Cancel') {
                  Fluttertoast.showToast(msg: '취소되었습니다.');
                  return;
                }
                // await db.close();
              } catch (error) {
                log(error.toString());
                Fluttertoast.showToast(msg: "QR코드 파싱중 오류가 발생했습니다.");
              }
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
