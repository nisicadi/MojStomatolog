import 'dart:convert';
import 'package:mojstomatolog_desktop/utils/util.dart';
import 'base_provider.dart';

class UserProvider extends BaseProvider<dynamic> {
  UserProvider() : super("User");

  Future<bool> login(String? username, String? password) async {
    if (username == null || password == null) {
      return false;
    }

    Map<String, String> headers = await createHeaders();

    try {
      var response = await http?.post(
        Uri.parse("${baseUrl}User/Login"),
        body: jsonEncode({"username": username, "password": password}),
        headers: headers,
      );

      if (response?.statusCode == 200 && response != null) {
        Authorization.username = username;
        Authorization.password = password;

        return true;
      } else {
        print("Login failed: ${response?.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error during login: $e");
      return false;
    }
  }

  void logOut() {
    Authorization.username = null;
    Authorization.password = null;
  }
}
