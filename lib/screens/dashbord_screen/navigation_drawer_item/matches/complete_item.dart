// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/custom_widgets/custom_resent_widget.dart';
import 'package:flutter/material.dart';

class CompleteItem extends StatefulWidget {
  const CompleteItem({super.key});

  @override
  State<CompleteItem> createState() => _CompleteItem();
}

class _CompleteItem extends State<CompleteItem> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth,
      child: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: CustomResentWidget(),
        );
      }),
    );
  }
}
