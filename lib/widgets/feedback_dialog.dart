import 'package:flutter/material.dart';

void showHandOverConfirmationDialog(
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
                child: Text('OK'),
              ),
            ],
          ));
}

void showScanPackageResultDialog(BuildContext context, Function scanQRCallback,
    bool success, String title, String message) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(title),
            content: FeedbackDialogContentWidget(success, message),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  scanQRCallback();
                },
                child: Text('Scan Next'),
              ),
            ],
          ));
}

void showLoading(BuildContext context) {
  showDialog(
      context: context,
      builder: (_) => SimpleDialog(
            children: [
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          ));
}

void showFeedbackDialog(
    BuildContext context, bool success, String title, String message) {
  showDialog(
      context: context,
      builder: (_) => AlertDialog(
            title: Text(title),
            content: FeedbackDialogContentWidget(success, message),
            actions: [
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ));
}

/// A reusable widget that contains a success/fail icon and message on a dialog
class FeedbackDialogContentWidget extends StatelessWidget {
  final bool _success;
  final String _message;

  FeedbackDialogContentWidget(this._success, this._message);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _success ? Icons.check_circle_outline : Icons.error_outline,
            size: 60,
            color: _success ? Colors.green.shade400 : Colors.red.shade400,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
            child: Text(
              _message,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
