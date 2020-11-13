import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projekt_studium_driver_app/models/person.dart';

import 'base_service.dart';

class PersonService extends BaseService {
  static Future<List<Person>> getData() async {
    final response = await http.get('${BaseService.baseUrl}/persons');

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => Person.fromJson(item))
          .toList();
    } else {
      throw Exception(
          'Failed to load persons, status code ${response.statusCode}: ${response.body}');
    }
  }
}
