import 'package:cricket_app/custom_widgets/expanded_aligned_text.dart';
import 'package:cricket_app/models/player.dart';
import 'package:flutter/material.dart';

class OdiCareerCard extends StatelessWidget {
  final Player? player;
  const OdiCareerCard({super.key, this.player});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
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
            const Text(
              'ODI Career',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Row(
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
                ExpandedAlignedText(player?.odiStats?.matches.toString() ?? ''),
                ExpandedAlignedText(player?.odiStats?.innings.toString() ?? ''),
                ExpandedAlignedText(player?.odiStats?.runs.toString() ?? ''),
                ExpandedAlignedText(
                    player?.odiStats?.highestScore.toString() ?? ''),
              ],
            )
          ],
        ),
      ),
    );
  }
}
