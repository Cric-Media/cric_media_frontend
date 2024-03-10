// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/custom_widgets/custom_up_coming_matches_card.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_score_card.dart';
import 'package:flutter/material.dart';

class UpComingItem extends StatefulWidget {
  const UpComingItem({super.key});

  @override
  State<UpComingItem> createState() => _UpComingItem();
}

class _UpComingItem extends State<UpComingItem> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      child: ListView.builder(itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
          child: UpCommingMachesCard(),
        );
      }),
    );
  }
}
