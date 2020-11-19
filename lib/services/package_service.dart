import 'dart:convert';
import 'dart:typed_data';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:http/http.dart' as http;
import 'package:projekt_studium_driver_app/exceptions/IllegalPackageStatusException.dart';
import 'package:projekt_studium_driver_app/exceptions/NotFoundException.dart';
import 'package:projekt_studium_driver_app/models/package.dart';
import 'package:projekt_studium_driver_app/services/base_service.dart';

class PackageService extends BaseService {
  static Future<List<Package>> getData() async {
    final response = await http.get('${BaseService.baseUrl}/packages');

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((item) => Package.fromJson(item))
          .toList();
    } else {
      throw Exception(
          'Failed to load packages, status code ${response.statusCode}: ${response.body}');
    }
  }

  static Future<Package> getPackageByIdOrBarcode(String queryNumber) async {
    final response =
        await http.get('${BaseService.baseUrl}/packages/$queryNumber');

    if (response.statusCode == 200) {
      return Package.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load package $queryNumber, status code ${response.statusCode}: ${response.body}');
    }
  }

  static Future<Package> updatePackageStatus(
      String queryNumber, PackageStatus status,
      {signature: Uint8List}) async {
    Map<String, String> body = new Map();
    body.putIfAbsent('status', () => EnumToString.convertToString(status));

    if (signature != null) {
      body.putIfAbsent('signature', () => base64.encode(signature));
    }

    final response = await http.put(
        '${BaseService.baseUrl}/packages/$queryNumber',
        headers: BaseService.headers,
        body: json.encode(body));

    switch (response.statusCode) {
      case 200:
        return Package.fromJson(json.decode(response.body));
      case 403:
        throw new IlleagalPackageStatusException(response.body);
      case 404:
        throw new NotFoundException(response.body);
      default:
        throw Exception(
            'Failed to update package $queryNumber, status code ${response.statusCode}: ${response.body}');
    }
  }
}
