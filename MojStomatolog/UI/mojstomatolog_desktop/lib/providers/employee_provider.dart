import 'package:mojstomatolog_desktop/models/employee.dart';
import 'base_provider.dart';

class EmployeeProvider extends BaseProvider<Employee> {
  EmployeeProvider() : super("Employee");

  @override
  Employee fromJson(data) {
    return Employee.fromJson(data);
  }
}
