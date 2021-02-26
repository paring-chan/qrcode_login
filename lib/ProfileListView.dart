import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qrlogin/pages/AddProfilePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'LoginProfile.dart';

class ProfileListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfileListView();
}

class _ProfileListView extends State<ProfileListView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.add),
          title: Text('프로필 추가하기'),
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddProfilePage()));
          },
        ),
        FutureBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData == false) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(fontSize: 15),
              ),
            );
          } else {
            return Text('test');
          }
        }, future: getProfiles(),)
      ],
    );
  }

  Future<List<LoginProfile>> getProfiles() async {
    var pref = await SharedPreferences.getInstance();
    var items = pref.getStringList("profiles");
    var result = <LoginProfile>[];
  }
}
