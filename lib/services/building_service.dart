import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projekt_studium_driver_app/models/building.dart';

import '../env.dart';

class BuildingService {
  final String _baseUrl = environment['baseUrl'];

  Future<List<Building>> getData() async {
    final response = await http.get('$_baseUrl/buildings');

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => Building.fromJson(item))
          .toList();
    } else {
      throw Exception(
          'Failed to load buildings, status code ${response.statusCode}');
    }
  }
}
