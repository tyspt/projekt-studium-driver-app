import 'dart:developer' as developer;

import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projekt_studium_driver_app/env.dart';
import 'package:projekt_studium_driver_app/package_state.dart';
import 'package:projekt_studium_driver_app/services/driver_service.dart';
import 'package:projekt_studium_driver_app/widgets/homepage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => PackageModel(),
      child: MyApp(),
    ),
  );

  // Scheduled job to upload driver location
  final cron = Cron();
  cron.schedule(Schedule.parse(environment['locationUpdateCron']), () async {
    developer.log('Reading current driver location...', name: 'location');
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    await DriverService.updateLocation(
        position.longitude, position.latitude, position.accuracy);
    developer.log('Done!', name: 'location');
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Logistic Driver App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Home Page'),
    );
  }
}
