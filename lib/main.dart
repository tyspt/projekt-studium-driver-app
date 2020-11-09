import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
      title: 'Continental Logistic Driver App',
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

  final _incomingPackages =
      PackageData.data.where((package) => package['type'] == Type.INBOUND);
  final _outgoingPackages =
      PackageData.data.where((package) => package['type'] == Type.OUTBOUND);

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
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _scanBarcode = barcodeScanRes;

      if (RegExp(r'^-?[0-9]+$').hasMatch(barcodeScanRes)) {
        showDialog(
            context: context,
            builder: (context) =>
                PackageDetailPopupDialog(_incomingPackages.last));
      } else {
        showDialog(
            context: context,
            builder: (context) => SimpleDialog(
                  title: Text('Starting handover process...'),
                  children: [
                    Center(
                      child: Text('...'),
                    )
                  ],
                ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            _selectedIndex == 0 ? 'Incoming Packages' : 'Outgoing Packages'),
      ),
      body: Center(
          child: PackageList(
              _selectedIndex == 0 ? _incomingPackages : _outgoingPackages)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => scanQR(),
        tooltip: 'Scan Barcode / QR Code',
        child: Icon(Icons.camera_alt),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.get_app), title: Text('Incoming')),
          BottomNavigationBarItem(
              icon: Icon(Icons.publish), title: Text('Outgoing')),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
      ),
    );
  }
}
