import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:typed_data';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:projekt_studium_driver_app/exceptions/IllegalPackageStatusException.dart';
import 'package:projekt_studium_driver_app/exceptions/NotFoundException.dart';
import 'package:projekt_studium_driver_app/models/package.dart';
import 'package:projekt_studium_driver_app/services/base_service.dart';

class PackageService extends BaseService {
  static Future<List<Package>> getData() async {
    developer.log("loading packages...", name: 'package');

    final response =
        await BaseService.client.get('${BaseService.baseUrl}/packages').timeout(
              Duration(seconds: BaseService.requestTimeout),
            );

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
    final response = await BaseService.client
        .get('${BaseService.baseUrl}/packages/$queryNumber')
        .timeout(
          Duration(seconds: BaseService.requestTimeout),
        );

    if (response.statusCode == 200) {
      return Package.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load package $queryNumber, status code ${response.statusCode}: ${response.body}');
    }
  }

  static Future<Package> updatePackageStatus(
      String queryNumber, PackageStatus status,
      {Uint8List signature}) async {
    Map<String, String> body = new Map();
    body.putIfAbsent('status', () => EnumToString.convertToString(status));

    if (signature != null) {
      body.putIfAbsent('signature', () => base64.encode(signature));
    }

    final response = await BaseService.client
        .put('${BaseService.baseUrl}/packages/$queryNumber',
            headers: BaseService.headers, body: json.encode(body))
        .timeout(
          Duration(seconds: BaseService.requestTimeout),
        );

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
