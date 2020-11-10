import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projekt_studium_driver_app/models/package.dart';

import '../env.dart';

class PackageService {
  final String _baseUrl = environment['baseUrl'];

  Future<List<Package>> getData() async {
    final response = await http.get('$_baseUrl/packages');

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => Package.fromJson(item))
          .toList();
    } else {
      throw Exception(
          'Failed to load packages, status code ${response.statusCode}');
    }
  }

  Future<Package> getPackageByIdOrBarcode(String queryNumber) async {
    final response = await http.get('$_baseUrl/packages/$queryNumber');

    if (response.statusCode == 200) {
      return Package.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load package $queryNumber, status code ${response.statusCode}');
    }
  }
}
