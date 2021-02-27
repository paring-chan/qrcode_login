import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final Map<String, dynamic> profile;

  ProfileTile(this.profile);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(profile['email']),
      subtitle: Text(profile['url']),
      onTap: () async {
      },
    );
  }
}
