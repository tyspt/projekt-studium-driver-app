import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';

class SignatureDrawer extends StatefulWidget {
  @override
  _SignatureDrawerState createState() => _SignatureDrawerState();
}

class _SignatureDrawerState extends State<SignatureDrawer> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  _saveSignature() async {
    final Uint8List result = await _controller.toPngBytes();
    Navigator.pop(context, result);
  }

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
            child: Column(children: [
      Signature(
        controller: _controller,
        backgroundColor: Colors.white,
      ),
      Divider(height: 1, thickness: 1, color: Colors.black38),
      Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Recipient Signature',
                style: GoogleFonts.cookie(
                  textStyle: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1,
                    color: Colors.black38,
                  ),
                ),
              ),
            ],
          )),
      Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height / 5,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RaisedButton.icon(
                color: Theme.of(context).primaryColor,
                onPressed: _saveSignature,
                label: Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.check,
                  color: Colors.white,
                )),
            SizedBox(
              width: 20,
            ),
            RaisedButton.icon(
                color: Theme.of(context).errorColor,
                onPressed: _controller.clear,
                label: Text(
                  'Clear',
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                )),
            SizedBox(
              width: 20,
            ),
          ],
        ),
      )
    ])));
  }
}
