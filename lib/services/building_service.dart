import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projekt_studium_driver_app/models/building.dart';

import 'base_service.dart';

class BuildingService extends BaseService {
  static Future<List<Building>> getData() async {
    final response = await http.get('${BaseService.baseUrl}/buildings');

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => Building.fromJson(item))
          .toList();
    } else {
      throw Exception(
          'Failed to load buildings, status code ${response.statusCode}: ${response.body}');
    }
  }
}
