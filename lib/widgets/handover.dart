import 'package:flutter/material.dart';

class StartHandOverConfirmationDialog extends StatelessWidget {
  final Function scanQRCallback;

  StartHandOverConfirmationDialog(this.scanQRCallback);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Starting handover process'),
      content: Text('Please now scan each package that you are going to take.'),
      actions: [
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
            scanQRCallback();
          },
          child: Text(
            'OK',
          ),
        ),
      ],
    );
  }
}
