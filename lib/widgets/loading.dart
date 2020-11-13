import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        Center(
          child: CircularProgressIndicator(),
        )
      ],
    );
  }
}
