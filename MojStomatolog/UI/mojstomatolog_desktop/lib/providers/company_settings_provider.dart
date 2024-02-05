import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mojstomatolog_desktop/utils/util.dart';
import 'package:open_file/open_file.dart';

class CompanySettingsProvider {
  final String _baseUrl = const String.fromEnvironment("baseUrl",
      defaultValue: "http://localhost:7043/");

  Future<void> addOrUpdate(String settingName, String settingValue) async {
    var url = Uri.parse('${_baseUrl}CompanySettings');
    var headers = await createHeaders();
    await http.post(url,
        body: json
            .encode({"settingName": settingName, "settingValue": settingValue}),
        headers: headers);
  }

  Future<Map<String, dynamic>> getByName(String settingName) async {
    var url = Uri.parse('${_baseUrl}CompanySettings/?settingName=$settingName');
    var headers = await createHeaders();

    var response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load setting');
    }
  }

  Future<void> getPdfReport() async {
    try {
      var url = Uri.parse('${_baseUrl}CompanySettings/GeneratePDF');
      var headers = await createHeaders();

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final tempDir = await Directory.systemTemp.createTemp();
        final filePath = '${tempDir.path}/Izvjestaj.pdf';

        final File pdfFile = File(filePath);
        await pdfFile.writeAsBytes(response.bodyBytes);

        OpenFile.open(filePath);
      } else {
        throw Exception('Failed to generate PDF report');
      }
    } catch (e) {
      throw Exception('An error occurred while generating the PDF report: $e');
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
