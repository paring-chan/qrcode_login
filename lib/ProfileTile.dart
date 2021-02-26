import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrlogin/LoginProfile.dart';

class ProfileTile extends StatelessWidget {
  ProfileTile(this._profile);

  final LoginProfile _profile;

  @override
  Widget build(BuildContext ctx) {
    return ListTile(
      leading: Icon(Icons.person),
      title: Text(_profile.name),
      subtitle: Text(_profile.email)
    );
  }
}