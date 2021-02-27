import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrlogin/db.dart';
import 'package:qrlogin/structures/ProfileTile.dart';

class ManagerProfiles extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManageProfiles();
}

class _ManageProfiles extends State<ManagerProfiles> {
  var profiles = <Map<String, dynamic>>[];

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
