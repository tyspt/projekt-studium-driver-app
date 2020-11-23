import 'dart:convert';

import 'package:projekt_studium_driver_app/models/employee.dart';

import 'base_service.dart';

class EmployeeService extends BaseService {
  static Future<List<Employee>> getData() async {
    final response = await BaseService.client
        .get('${BaseService.baseUrl}/employees')
        .timeout(
          Duration(seconds: BaseService.requestTimeout),
        );

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => Employee.fromJson(item))
          .toList();
    } else {
      throw Exception(
          'Failed to load employees, status code ${response.statusCode}: ${response.body}');
    }
  }
}
