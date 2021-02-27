import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrlogin/db.dart';

class DeleteProfiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DeleteProfiles();
}

class _DeleteProfiles extends State<DeleteProfiles> {
  var profiles = <Map<String, dynamic>>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필 삭제하기'),
      ),
      body: Column(
        children: [
          ListView(
            children: profiles.map((e) => ListTile(
              title: Text(e['email']),
              subtitle: Text(e['url']),
            )).toList(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
          )
        ],
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
