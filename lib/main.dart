import 'package:flutter/material.dart';
import 'package:projekt_studium_driver_app/models/package.dart';
import 'package:projekt_studium_driver_app/services/package_data.dart';
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
        onPressed: null,
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
