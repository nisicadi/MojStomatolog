import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mojstomatolog_desktop/models/working_hours.dart';
import 'package:mojstomatolog_desktop/providers/base_provider.dart';
import 'package:open_file/open_file.dart';

class CompanySettingsProvider extends BaseProvider<WorkingHours> {
  CompanySettingsProvider() : super("CompanySettings");

  Future<void> getPdfReport() async {
    try {
      var url = Uri.parse('${baseUrl}CompanySettings/GeneratePDF');
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

  @override
  WorkingHours fromJson(data) {
    return WorkingHours.fromJson(data);
  }
}
