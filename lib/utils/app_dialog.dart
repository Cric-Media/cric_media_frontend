import 'package:flutter/material.dart';

class AppDialogs {
  static BuildContext? dialogueContext;
  static Future<dynamic> loadingDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible:
          false, // Prevent dismissing the dialog by tapping outside
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(child: CircularProgressIndicator()),
              SizedBox(height: 16),
              Text('Please Wait...'),
            ],
          ),
        );
      },
    );
  }

  static void closeDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
