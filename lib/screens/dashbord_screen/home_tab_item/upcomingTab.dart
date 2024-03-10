// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/custom_widgets/custom_up_coming_matches_card.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/matchesDetails.dart';
import 'package:flutter/material.dart';

class UpComingTab extends StatelessWidget {
  const UpComingTab({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
        SizedBox(
          height: screenHeight * 0.010,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MatcheDetails()));
                      },
                      child: UpCommingMachesCard()),
                );
              }),
        ),
        SizedBox(
          height: 70,
        )
      ]),
    );
  }
}
