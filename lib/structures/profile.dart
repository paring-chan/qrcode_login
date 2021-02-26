class Profile {
  String email;
  String password;
  String requestURL;

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'url': requestURL
    };
  }
}