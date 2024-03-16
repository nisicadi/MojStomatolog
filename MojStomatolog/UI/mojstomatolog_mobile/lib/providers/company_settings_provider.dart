import 'package:mojstomatolog_mobile/models/working_hours.dart';
import 'package:mojstomatolog_mobile/providers/base_provider.dart';

class CompanySettingsProvider extends BaseProvider<WorkingHours> {
  CompanySettingsProvider() : super("CompanySettings");

  @override
  WorkingHours fromJson(data) {
    return WorkingHours.fromJson(data);
  }
}
