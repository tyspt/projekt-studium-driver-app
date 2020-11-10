import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:projekt_studium_driver_app/services/package_service.dart';

import 'models/package.dart';
import 'services/package_data.dart';
import 'widgets/package_list.dart';

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

  final _inboundPackages = PackageData.data
      .where((package) => package['type'] == PackageType.INBOUND);
  final _outboundPackages = PackageData.data
      .where((package) => package['type'] == PackageType.OUTBOUND);

  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    print('Scan QR called');
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = '';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _scanBarcode = barcodeScanRes;

      if (barcodeScanRes.isEmpty || barcodeScanRes == '-1') {
        return;
      }

//      RegExp(r'^-?[0-9]+$').hasMatch(barcodeScanRes)
//          ? showDialog(
//              context: context,
//              builder: (_) => PackageDetailPopupDialog()
//          : showDialog(
//              context: context,
//              builder: (_) => StartHandOverConfirmationDialog(scanQR));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _selectedIndex == 0 ? 'Inbound Packages' : 'Outbound Packages'),
      ),
      body: Center(
          child: FutureBuilder<List<Package>>(
        future: PackageService.getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PackageList(_selectedIndex == 0
                ? snapshot.data
                    .where((package) => package.type == PackageType.INBOUND)
                : snapshot.data
                    .where((package) => package.type == PackageType.OUTBOUND));
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      )),
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
