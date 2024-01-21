import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mojstomatolog_mobile/utils/util.dart';

class CompanySettingsProvider {
  final String _baseUrl = 'https://10.0.2.2:7043/CompanySettings';

  Future<Map<String, dynamic>> getByName(String settingName) async {
    var url = Uri.parse('$_baseUrl/?settingName=$settingName');
    var headers = await createHeaders();

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
