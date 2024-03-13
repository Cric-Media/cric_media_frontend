import 'package:flutter/material.dart';

void showSnack(BuildContext context,
    {required String message,
    String actionLabel = 'Action',
    VoidCallback? action}) {
  final snackBar = SnackBar(
    content: Text(message, style: const TextStyle(color: Colors.white)),
    backgroundColor: Colors.deepPurple,
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
      label: actionLabel,
      textColor: Colors.yellow,
      onPressed: action ?? () {},
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
