import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrlogin/db.dart';

class ProfileTile extends StatelessWidget {
  final Map<String, dynamic> profile;

  ProfileTile(this.profile, this.reload);

  final Function reload;

  @override
  Widget build(BuildContext context) {
    var _emailController = TextEditingController();
    var _passwordController = TextEditingController();

    _emailController.text = profile['email'];
    _passwordController.text = profile['password'];

    var _formKey = GlobalKey<FormState>();

    return ListTile(
      title: Text(profile['email']),
      subtitle: Text(profile['url']),
      onTap: () async {
        var data = await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('프로필 수정'),
                content: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(hintText: '이메일'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return '이메일을 입력해주세요.';
                          }
                          return null;
                        },
                        controller: _emailController,
                      ),
                      TextFormField(
                        decoration: InputDecoration(hintText: '비밀번호'),
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
                        Navigator.pop(context, false);
                      },
                      child: Text('취소')),
                  TextButton(onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (context) {
                      return AlertDialog(
                        title: Text('프로필 삭제'),
                        content: Text('프로필을 삭제할까요?'),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context, false);
                              },
                              child: Text('취소')),
                          TextButton(onPressed: () async {
                            var db = await DB.getDB();
                            await db.delete('profiles', where: 'id = ?', whereArgs: [profile['id']]);
                            await db.close();
                            Navigator.pop(context, true);
                            Navigator.pop(context, true);
                            await reload();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('프로필이 삭제되었습니다.')));
                          }, child: Text('확인'))
                        ],
                      );
                    },
                    barrierDismissible: false);
                  }, child: Text('삭제')),
                  TextButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          Navigator.of(context).pop(true);
                        }
                      },
                      child: Text('저장'))
                ],
              );
            },
            barrierDismissible: false);
        if (data == true) {
          var db = await DB.getDB();
          await db.update('profiles', {
            'email': _emailController.text,
            'password': _passwordController.text
          });
          await db.close();
          await reload();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('프로필이 저장되었습니다.')));
        }
      },
    );
  }
}
