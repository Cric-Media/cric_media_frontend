// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/custom_widgets/expanded_aligned_text.dart';
import 'package:cricket_app/models/player.dart';
import 'package:flutter/material.dart';

class T20CareerCard extends StatelessWidget {
  final Player? player;
  const T20CareerCard({super.key, this.player});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset.zero,
              blurRadius: 1.0,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'T20 Career',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 7,
            ),
            Row(
              children: [
                ExpandedAlignedText('M'),
                ExpandedAlignedText('INN'),
                ExpandedAlignedText('RUNS'),
                ExpandedAlignedText('HS'),
                // ExpandedAlignedText('SR'),
              ],
            ),
            Row(
              children: [
                ExpandedAlignedText(player?.t20Stats?.matches.toString() ?? ''),
                ExpandedAlignedText(player?.t20Stats?.innings.toString() ?? ''),
                ExpandedAlignedText(player?.t20Stats?.runs.toString() ?? ''),
                ExpandedAlignedText(
                    player?.t20Stats?.highestScore.toString() ?? ''),
              ],
            )
          ],
        ),
      ),
    );
  }
}
