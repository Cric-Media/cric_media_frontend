// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cricket_app/custom_widgets/live_custom_widget.dart';
import 'package:flutter/material.dart';

class Live extends StatelessWidget {
  const Live({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SizedBox(
          height: 10,
        ),
        LiveCustomWidgt(),
        SizedBox(
          height: 20,
        ),
      ]),
    );
  }
}
