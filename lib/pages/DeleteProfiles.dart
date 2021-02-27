import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteProfiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeleteProfiles();
}

class _DeleteProfiles extends State<DeleteProfiles> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 삭제하기'),
      ),
    );
  }
}