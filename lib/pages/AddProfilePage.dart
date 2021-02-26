import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddProfilePage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

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
                    return '텍스트를 입력해주세요';
                  } else
                    return null;
                },
                decoration: InputDecoration(
                  hintText: '이메일'
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}