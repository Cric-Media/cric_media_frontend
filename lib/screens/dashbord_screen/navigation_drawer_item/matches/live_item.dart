// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/custom_widgets/custom_home_card.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_score_card.dart';
import 'package:flutter/material.dart';

class LiveItem extends StatefulWidget {
  const LiveItem({super.key});

  @override
  State<LiveItem> createState() => _LiveItem();
}

class _LiveItem extends State<LiveItem> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      child: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: CustomHomeCard(),
        );
      }),
    );
  }
}
