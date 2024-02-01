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

        User.userId = jsonDecode(response.body)['userId'];
        User.firstName = jsonDecode(response.body)['firstName'];
        User.lastName = jsonDecode(response.body)['lastName'];
        User.email = jsonDecode(response.body)['email'];
        User.number = jsonDecode(response.body)['number'];

        print(User.firstName);

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

  @override
  dynamic fromJson(data) {
    return data;
  }

  void logOut() {
    Authorization.username = null;
    Authorization.password = null;
  }

  Future<bool> register(String username, String email, String password) async {
    var response = await http?.post(Uri.parse("${baseUrl}User/Register"),
        body: jsonEncode(<String, dynamic>{
          "username": username,
          "email": email,
          "password": password
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    print(response?.statusCode);
    if (response?.statusCode == 200) {
      print("Registration success");
      return true;
    } else {
      print("Registration error here");
      return false;
    }
  }

  Future<bool> changePassword(int userId, String currentPassword,
      String newPassword, String confirmPassword) async {
    Map<String, String> headers = await createHeaders();

    try {
      var response = await http?.post(
        Uri.parse("${baseUrl}User/$userId/ChangePassword"),
        body: jsonEncode({
          "currentPassword": currentPassword,
          "newPassword": newPassword,
          "confirmPassword": confirmPassword,
        }),
        headers: headers,
      );

      if (response?.statusCode == 200) {
        Authorization.password = newPassword;
        return true;
      } else {
        print("Change password failed: ${response?.statusCode}");
        return false;
      }
    } catch (e) {
      print("Error during password change: $e");
      return false;
    }
  }
}
