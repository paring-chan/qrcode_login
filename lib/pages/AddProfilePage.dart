import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrlogin/LoginProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AddProfilePage extends StatefulWidget {
  @override
  _AddProfilePage createState() => _AddProfilePage();
}

class _AddProfilePage extends State {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  dispose() {
    nameController.dispose();
    emailController.dispose();
    pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 추가'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return '프로필 이름을 입력해주세요';
                  } else
                    return null;
                },
                controller: nameController,
                decoration: InputDecoration(
                  hintText: '프로필 이름'
                ),
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return '이메일 입력해주세요';
                  } else
                    return null;
                },
                decoration: InputDecoration(
                    hintText: '이메일'
                ),
                controller: emailController,
              ),
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return '비밀번호를 입력해주세요';
                  } else
                    return null;
                },
                decoration: InputDecoration(
                    hintText: '비밀번호',
                ),
                obscureText: true,
                controller: pwController,
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    var list = prefs.getStringList('profiles');
                    if (list == null) {
                      list = <String>[];
                    }
                    list.add(json.encode(buildProfile(emailController.text, nameController.text, pwController.text).toJson()));
                    prefs.setStringList('profiles', list);
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('프로필이 추가되었습니다.')));
                  }
                }, child: Text('추가하기')),
              )
              )
            ],
          ),
        )
      ),
    );
  }
}