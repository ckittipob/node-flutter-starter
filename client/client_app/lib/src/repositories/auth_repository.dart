import 'dart:convert';
import 'package:http/http.dart' as http;

const _root = 'http://localhost:5000/api';

class AuthRepository {
  Future<String> login(String username, String password) async {
    final Map<String, String> customHeaders = {
      "content-type": "application/json"
    };

    final response = await http.post(Uri.parse('$_root/auth'),
        headers: customHeaders,
        body: json.encode({'email': username, 'password': password}));

    final jwt = json.decode(response.body);
    return jwt['token'];
  }
}
