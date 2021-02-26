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
                    return '프로필 이름을 입력해주세요';
                  } else
                    return null;
                },
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
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton(onPressed: () {}, child: Text('추가하기')),
              )
              )
            ],
          ),
        )
      ),
    );
  }
}