import 'package:flutter/material.dart';

class HandoverDialogs {
  static void showHandOverConfirmationDialog(
      BuildContext context, Function scanQRCallback) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text('Starting handover process'),
              content: Text(
                  'Please now scan each package that you are going to take.'),
              actions: [
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
            ));
  }

  static void showAddPackageFeedbackDialog(BuildContext context,
      Function scanQRCallback, bool success, String title, String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: Container(
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      success
                          ? Icons.check_circle_outline
                          : Icons.error_outline,
                      size: 60,
                      color:
                          success ? Colors.green.shade400 : Colors.red.shade400,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
                      child: Text(
                        message,
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    scanQRCallback();
                  },
                  child: Text(
                    'Scan Next',
                  ),
                ),
              ],
            ));
  }
}
