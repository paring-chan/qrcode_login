import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrlogin/db.dart';
import 'package:qrlogin/structures/ProfileTile.dart';
import 'package:qrlogin/structures/profile.dart';
import 'package:sqflite/sqflite.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:fluttertoast/fluttertoast.dart';

class ManagerProfiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageProfiles();
}

class _ManageProfiles extends State<ManagerProfiles> {
  var profiles = <Map<String, dynamic>>[];

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 관리하기'),
      ),
      body: Column(
        children: [
          ListView(
            children: profiles.map((e) => ProfileTile(e, load)).toList(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          if (await Permission.camera.request().isGranted) {
            try {
              String result = await scanner.scan();
              var res = json.decode(result);
              if (res['RequestURL'] == null) throw Error();
              var db = await DB.getDB();
              var data = await showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('프로필 등록'),
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
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text('프로필이 저장되었습니다.')));
            } catch (error) {
              log(error.toString());
              Fluttertoast.showToast(msg: "QR코드 파싱중 오류가 발생했습니다.");
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('카메라 사용 권한을 허용해주세요.')));
          }
        },
      ),
    );
  }

  @override
  initState() {
    super.initState();
    load();
  }

  Future load() async {
    var db = await DB.getDB();
    try {
      var profiles = await db.query('profiles');
      setState(() {
        this.profiles = profiles;
      });
    } finally {
      await db.close();
    }
  }
}
