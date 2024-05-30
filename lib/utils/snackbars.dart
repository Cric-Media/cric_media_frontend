import 'package:cricket_app/constants/app_color.dart';
import 'package:flutter/material.dart';

/// Shows a Snackbar with the given [message].
///
/// The [actionLabel] and [action] parameters are optional. If [action] is provided,
/// a button with the text [actionLabel] will be added to the Snackbar, and [action]
/// will be called when the button is pressed.
///
/// The Snackbar will be shown for 3 seconds.
void showSnack(
  BuildContext context, {
  required String message,
  String actionLabel = 'Action',
  VoidCallback? action,
}) {
  // hide previous snackbar
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  // Create the Snackbar
  final snackBar = SnackBar(
    // Remove "Exception:" from the message and display it
    content: Text(
      message.replaceAll("Exception:", ''),
      style: const TextStyle(color: Colors.white),
    ),
    // Set the background color to blue
    backgroundColor: AppColor.blueColor,
    // Show the Snackbar for 3 seconds
    duration: const Duration(seconds: 3),
    // If an action is provided, add a button to the Snackbar
    action: action == null
        ? null
        : SnackBarAction(
            label: actionLabel,
            textColor: Colors.yellow,
            onPressed: action,
          ),
  );

  // Try to show the Snackbar
  try {
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  } catch (e) {
    // If an error occurs, print it to the console
  }
}
