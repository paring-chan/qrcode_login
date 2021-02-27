import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final Map<String, dynamic> profile;

  ProfileTile(this.profile);

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
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('계정 등록'),
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
                        Navigator.pop(context, true);
                      },
                      child: Text('취소')),
                  TextButton(onPressed: () {}, child: Text('삭제')),
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
      },
    );
  }
}
