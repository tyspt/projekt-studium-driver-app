import 'dart:convert';

import 'package:projekt_studium_driver_app/exceptions/HandoverClosedException.dart';
import 'package:projekt_studium_driver_app/exceptions/IllegalPackageStatusException.dart';
import 'package:projekt_studium_driver_app/models/handover.dart';
import 'package:projekt_studium_driver_app/services/base_service.dart';

class HandoverService extends BaseService {
  static Future<Handover> findByUuid(String uuid) async {
    final response = await BaseService.client
        .get('${BaseService.baseUrl}/handovers/$uuid')
        .timeout(
          Duration(seconds: BaseService.requestTimeout),
        );

    if (response.statusCode == 200) {
      return Handover.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to load handover $uuid, status code ${response.statusCode}: ${response.body}');
    }
  }

  static Future<Handover> createHandover(String uuid) async {
    Map<String, String> body = new Map();
    body.putIfAbsent('uuid', () => uuid);

    final response = await BaseService.client
        .post('${BaseService.baseUrl}/handovers',
            headers: BaseService.headers, body: json.encode(body))
        .timeout(
          Duration(seconds: BaseService.requestTimeout),
        );

    if (response.statusCode == 201) {
      return Handover.fromJson(json.decode(response.body));
    } else {
      throw Exception(
          'Failed to create handover $uuid, status code ${response.statusCode}: ${response.body}');
    }
  }

  static Future<Handover> addPackage(
      String handoverUuid, String pkgIdOrBarcode) async {
    Map<String, String> body = new Map();
    body.putIfAbsent('idOrBarcode', () => pkgIdOrBarcode);

    final response = await BaseService.client
        .put('${BaseService.baseUrl}/handovers/$handoverUuid',
            headers: BaseService.headers, body: json.encode(body))
        .timeout(
          Duration(seconds: BaseService.requestTimeout),
        );

    switch (response.statusCode) {
      case 200:
        return Handover.fromJson(json.decode(response.body));
      case 403:
      case 404:
        // Package not in a status that can be added to handover
        throw new IlleagalPackageStatusException(response.body);
      case 410:
        // Handover is already confirmed, canceled or has not been created yet
        throw new HandoverClosedException(response.body);
      default:
        throw Exception(
            'Failed to add package $pkgIdOrBarcode to handover $handoverUuid, status code ${response.statusCode}: ${response.body}');
    }
  }
}
