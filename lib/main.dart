import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:projekt_studium_driver_app/services/package_service.dart';
import 'package:projekt_studium_driver_app/widgets/handover.dart';

import 'models/package.dart';
import 'widgets/package_card.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  bool _isInHandoverMode =
      false; // Flag used to determine the behavior of QR scanner
  List<Package> _packages = [];

  @override
  void initState() {
    super.initState();
    _loadPackages();
  }

  void _loadPackages() async {
    final result = await PackageService.getData();
    setState(() {
      _packages = result;
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
    } on PlatformException {
      barcodeScanRes = '';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    if (barcodeScanRes.isEmpty || barcodeScanRes == '-1') {
      return;
    }

    final isNumber = RegExp(r'^-?[0-9]+$').hasMatch(barcodeScanRes);

    if (!_isInHandoverMode) {
      if (isNumber) {
        // Display package detail
        final package =
            await PackageService.getPackageByIdOrBarcode(barcodeScanRes);
        showDialog(
            context: context,
            builder: (_) => PackageDetailPopupDialog(package));
      } else {
        // Start package handover mode
        _isInHandoverMode = true; // TODO: exit hanover mode after finish
        showDialog(
            context: context,
            builder: (_) => StartHandOverConfirmationDialog(scanQR));
      }
    } else {
      await PackageService.updatePackageStatus(
          barcodeScanRes, PackageStatus.IN_HANDOVER);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _selectedIndex == 0 ? 'Inbound Packages' : 'Outbound Packages'),
      ),
      body: Center(
          child: _packages.length > 0
              ? RefreshIndicator(
                  onRefresh: () async => (await _loadPackages()),
                  child: ListView(
                    children: _packages
                        .map<Widget>((package) => PackageListItem(package))
                        .toList(),
                  ),
                )
              : CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () => scanQR(),
        tooltip: 'Scan Barcode / QR Code',
        child: Icon(Icons.camera_alt),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.get_app), title: Text('Inbound')),
          BottomNavigationBarItem(
              icon: Icon(Icons.publish), title: Text('Outbound')),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
