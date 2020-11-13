import 'package:flutter/material.dart';

class Loading {
  static void showLoading(BuildContext context) {
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
}
