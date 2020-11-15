import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:projekt_studium_driver_app/exceptions/HandoverClosedException.dart';
import 'package:projekt_studium_driver_app/exceptions/IlleagalPackageStatusException.dart';
import 'package:projekt_studium_driver_app/models/package.dart';
import 'package:projekt_studium_driver_app/package_state.dart';
import 'package:projekt_studium_driver_app/services/handover_service.dart';
import 'package:projekt_studium_driver_app/services/package_service.dart';
import 'package:projekt_studium_driver_app/widgets/package_detail.dart';
import 'package:projekt_studium_driver_app/widgets/package_list.dart';
import 'package:provider/provider.dart';

import 'feedback_dialog.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Index of the bottom navigator tab that is currently selected
  int _selectedIndex = 0;

  // The uuid of the ongoing handover, which is also used to determine the behavior of QR scanner
  String _currentHandoverUUID;

  @override
  void initState() {
    super.initState();
    _loadPackages();
  }

  void _loadPackages() async {
    final result = await PackageService.getData();
    Provider.of<PackageModel>(context, listen: false).reloadAll(result);
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

    if (!mounted || barcodeScanRes.isEmpty || barcodeScanRes == '-1') {
      // Exit the handover mode and do a page refresh if next scan is cancelled
      _currentHandoverUUID = null;
      _loadPackages();
      return;
    }

    // If scan result is a number, it would be recognized as the id or barcode of a package
    final isPackageIdOrBarcode = RegExp(r'^-?[0-9]+$').hasMatch(barcodeScanRes);

    if (!isPackageIdOrBarcode) {
      // Start package handover mode
      final resDecoded = json.decode(barcodeScanRes);
      if (resDecoded['action'] == 'handover') {
        _currentHandoverUUID = resDecoded['data'];

        showLoading(context);
        await HandoverService.createHandover(_currentHandoverUUID);
        Navigator.pop(context);
        showHandOverConfirmationDialog(context, scanQR);
      }
      return;
    }

    showLoading(context);
    if (_currentHandoverUUID != null) {
      // If in handover mode -> add scanned package to ongoing handover
      try {
        await HandoverService.addPackage(_currentHandoverUUID, barcodeScanRes);
        Navigator.pop(context);
        showAddPackageFeedbackDialog(context, scanQR, true, "Success",
            "Package has been successfully added to handover list.");
        return;
      } on IlleagalPackageStatusException catch (err) {
        Navigator.pop(context);
        showAddPackageFeedbackDialog(context, scanQR, false,
            "Failed to add package", "Error: " + err.toString());
        return;
      } on HandoverClosedException {
        _currentHandoverUUID = null;
      }
    }

    // Display package detail popup
    final Package package =
        await PackageService.getPackageByIdOrBarcode(barcodeScanRes);
    Navigator.pop(context);
    showPackageDetailDialog(context, package, scanQR);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _selectedIndex == 0 ? 'Inbound Packages' : 'Outbound Packages'),
      ),
      body: Center(
        child: Consumer<PackageModel>(
          builder: (context, model, child) {
            return model.packages.length > 0
                ? RefreshIndicator(
                    onRefresh: () async => (await _loadPackages()),
                    child: PackageList(
                        _selectedIndex == 0
                            ? model.inboundPackages
                            : model.outboundPackages,
                        scanQR))
                : CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: scanQR,
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
