import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projekt_studium_driver_app/services/driver_service.dart';
import 'package:provider/provider.dart';

import './env.dart';
import './package_state.dart';
import './widgets/homepage.dart';

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
    print('uploading driver location...');
    await DriverService.updateLocation(12, 12);
    print('done...');
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
