import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:projekt_studium_driver_app/exceptions/HandoverClosedException.dart';
import 'package:projekt_studium_driver_app/exceptions/IlleagalPackageStatusException.dart';
import 'package:projekt_studium_driver_app/models/handover.dart';
import 'package:projekt_studium_driver_app/services/base_service.dart';

class HandoverService extends BaseService {
  static Future<Handover> findByUuid(String uuid) async {
    final response = await http.get('${BaseService.baseUrl}/handovers/$uuid');

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

    final response = await http.post('${BaseService.baseUrl}/handovers',
        headers: BaseService.headers, body: json.encode(body));

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

    final response = await http.put(
        '${BaseService.baseUrl}/handovers/$handoverUuid',
        headers: BaseService.headers,
        body: json.encode(body));

    print(response.statusCode);

    switch (response.statusCode) {
      case 200:
        return Handover.fromJson(json.decode(response.body));
      case 403:
        // Package not in a status that can be added to handover
        throw new IlleagalPackageStatusException(response.body);
      case 404:
      case 410:
        // Handover is already confirmed, canceled or has not been created yet
        throw new HandoverClosedException(response.body);
      default:
        throw Exception(
            'Failed to add package $pkgIdOrBarcode to handover $handoverUuid, status code ${response.statusCode}: ${response.body}');
    }
  }
}
