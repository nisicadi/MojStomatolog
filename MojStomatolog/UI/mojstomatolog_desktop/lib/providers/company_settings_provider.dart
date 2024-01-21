import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mojstomatolog_desktop/utils/util.dart';

class CompanySettingsProvider {
  final String _baseUrl = 'https://localhost:7043/CompanySettings';

  Future<void> addOrUpdate(String settingName, String settingValue) async {
    var url = Uri.parse('$_baseUrl');
    var headers = await createHeaders();
    await http.post(url,
        body: json
            .encode({"settingName": settingName, "settingValue": settingValue}),
        headers: headers);
  }

  Future<Map<String, dynamic>> getByName(String settingName) async {
    var url = Uri.parse('$_baseUrl/?settingName=$settingName');
    var headers = await createHeaders();

    print(url);

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load setting');
    }
  }

  Future<Map<String, String>> createHeaders() async {
    String username = Authorization.username ?? "";
    String password = Authorization.password ?? "";

    String basicAuth =
        "Basic ${base64Encode(utf8.encode('$username:$password'))}";

    var headers = {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    };
    return headers;
  }
}
