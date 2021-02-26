import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrlogin/pages/AddProfilePage.dart';

class ProfileListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.add),
          title: Text('프로필 추가하기'),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddProfilePage()));
          },
        ),
      ],
    );
  }
}