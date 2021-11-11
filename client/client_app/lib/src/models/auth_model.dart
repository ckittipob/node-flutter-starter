class AuthModel {
  final String username;
  final String password;

  AuthModel.fromJson(Map<String, dynamic> parsedJson)
      : username = parsedJson['username'],
        password = parsedJson['password'];
}
