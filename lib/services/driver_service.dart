import 'dart:convert';
import 'dart:developer' as developer;

import 'package:http/http.dart' as http;
import 'package:projekt_studium_driver_app/exceptions/IllegalPackageStatusException.dart';
import 'package:projekt_studium_driver_app/exceptions/NotFoundException.dart';
import 'package:projekt_studium_driver_app/models/driver.dart';

import 'base_service.dart';

class DriverService extends BaseService {
  static Future<Driver> updateLocation(
      double longitude, double latitude, double accuracy) async {
    Map<String, double> body = new Map();
    body.putIfAbsent('longitude', () => longitude);
    body.putIfAbsent('latitude', () => latitude);
    body.putIfAbsent('accuracy', () => accuracy);

    developer.log('Uploading to server... data: ' + body.toString(),
        name: 'location');

    final response = await http.put('${BaseService.baseUrl}/drivers/location',
        headers: BaseService.headers, body: json.encode(body));

    switch (response.statusCode) {
      case 200:
        return Driver.fromJson(json.decode(response.body));
      case 403:
        throw new IlleagalPackageStatusException(response.body);
      case 404:
        throw new NotFoundException(response.body);
      default:
        throw Exception(
            'Failed to update driver location, status code ${response.statusCode}: ${response.body}');
    }
  }
}
