class LoginProfile {
  String name;
  String email;
  String password;
}

LoginProfile buildProfile(String email, String name, String password) {
  var profile = LoginProfile();
  profile.email = email;
  profile.name = name;
  profile.password = password;
  return profile;
}
