import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projekt_studium_driver_app/models/employee.dart';

import 'base_service.dart';

class EmployeeService extends BaseService {
  static Future<List<Employee>> getData() async {
    final response = await http.get('${BaseService.baseUrl}/employees');

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
