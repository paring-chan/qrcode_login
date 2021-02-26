class LoginProfile {
  String name;
  String email;
  String password;

  LoginProfile();

  Map<String, dynamic> toJson() =>
      {
        'name': name,
        'email': email,
        'password': password
      };

  LoginProfile.fromJson(Map<String, dynamic> json):
        name = json['name'],
        email = json['email'],
        password = json['password'];
}

LoginProfile buildProfile(String email, String name, String password) {
  var profile = LoginProfile();
  profile.email = email;
  profile.name = name;
  profile.password = password;
  return profile;
}
