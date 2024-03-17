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

  static Future<dynamic> showConfirmationDialog(BuildContext context,
      {required String title,
      required String message,
      required Function onPressed}) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context)
                    .pop(false); // Dismiss dialog and return false
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                Navigator.pop(context);
                onPressed();
              },
            ),
          ],
        );
      },
    );
  }
}
