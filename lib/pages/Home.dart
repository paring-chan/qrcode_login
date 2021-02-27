import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrlogin/db.dart';
import 'package:qrlogin/pages/ManageProfiles.dart';
import 'package:qrlogin/structures/profile.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext ctx) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QRCODE LOGIN'),
      ),
      body: Center(
          child: Column(
        children: [
          OutlinedButton(
              onPressed: () async {
                if (await Permission.camera.request().isGranted) {
                  try {
                    String result = await scanner.scan();
                    var res = json.decode(result);
                    if (res['RequestURL'] == null) throw Error();
                    var db = await DB.getDB();
                    var data = await showDialog(
                        context: ctx,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('계정 등록'),
                            content: Form(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextFormField(
                                    decoration:
                                        InputDecoration(hintText: '이메일'),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '이메일을 입력해주세요.';
                                      }
                                      return null;
                                    },
                                    controller: _emailController,
                                  ),
                                  TextFormField(
                                    decoration:
                                        InputDecoration(hintText: '비밀번호'),
                                    obscureText: true,
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return '비밀번호를 입력해주세요.';
                                      }
                                      return null;
                                    },
                                    controller: _passwordController,
                                  ),
                                ],
                              ),
                              key: _formKey,
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, "Cancel");
                                  },
                                  child: Text('취소')),
                              TextButton(
                                  onPressed: () {
                                    if (_formKey.currentState.validate()) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Text('저장'))
                            ],
                          );
                        },
                        barrierDismissible: false);
                    if (data == 'Cancel') {
                      Fluttertoast.showToast(msg: '취소되었습니다.');
                      await db.close();
                      return;
                    }
                    var profile = Profile();

                    profile.requestURL = res['RequestURL'];
                    profile.email = _emailController.text;
                    profile.password = _passwordController.text;

                    await db.insert('profiles', profile.toMap(),
                        conflictAlgorithm: ConflictAlgorithm.replace);
                    await db.close();
                    ScaffoldMessenger.of(ctx)
                        .showSnackBar(SnackBar(content: Text('프로필이 저장되었습니다.')));
                  } catch (error) {
                    log(error.toString());
                    Fluttertoast.showToast(msg: "QR코드 파싱중 오류가 발생했습니다.");
                  }
                } else {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                      SnackBar(content: Text('카메라 사용 권한을 허용해주세요.')));
                }
              },
              child: Text('계정 추가하기')),
          OutlinedButton(
              onPressed: () async {
                if (await Permission.camera.request().isGranted) {
                  var db = await DB.getDB();
                  try {
                    String result = await scanner.scan();
                    var decoded = json.decode(result);
                    var data = (await db.query('profiles',
                        where: 'url = ?',
                        whereArgs: [decoded['RequestURL']],
                        limit: 1));
                    if (data.length == 0) {
                      log("null");
                      await showDialog(
                          context: ctx,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('프로필 없음'),
                              content: Text('프로필이 등록되어 있지 않습니다. 먼저 프로필을 등록해주세요.'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('확인'))
                              ],
                            );
                          },
                          barrierDismissible: false);
                      return;
                    }
                    var res = data[0];
                    await http.post(Uri.parse(res['url']),
                        headers: {'Content-Type': 'application/json'},
                        body: json.encode({
                          'email': res['email'],
                          'password': res['password'],
                          'appversion': 2,
                          'alphaapp': 'false',
                          'socketID': decoded['socketID']
                        }));
                    ScaffoldMessenger.of(ctx).showSnackBar(
                        SnackBar(content: Text('로그인 요청이 완료되었습니다.')));
                  } finally {
                    await db.close();
                  }
                } else {
                  ScaffoldMessenger.of(ctx).showSnackBar(
                      SnackBar(content: Text('카메라 사용 권한을 허용해주세요.')));
                }
              },
              child: Text('QR코드 스캔하기')),
          OutlinedButton(onPressed: () {
            Navigator.push(ctx, MaterialPageRoute(builder: (context) => ManagerProfiles()));
          }, child: Text('프로필 관리'))
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
      )),
    );
  }
}
