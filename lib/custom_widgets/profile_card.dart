import 'package:cricket_app/custom_widgets/expanded_aligned_text.dart';
import 'package:cricket_app/models/player.dart';
import 'package:flutter/material.dart';

class LatestPerformanceCard extends StatelessWidget {
  final Player? player;
  const LatestPerformanceCard({super.key, this.player});

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
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Latest Performance',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ExpandedAlignedText('R'),
                ExpandedAlignedText('B'),
                ExpandedAlignedText('6'),
                ExpandedAlignedText('4'),
                ExpandedAlignedText('HS'),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ExpandedAlignedText(
                    player?.lastPerformance?.runs.toString() ?? ''),
                ExpandedAlignedText(
                    player?.lastPerformance?.balls.toString() ?? ''),
                ExpandedAlignedText(
                    player?.lastPerformance?.sixes.toString() ?? ''),
                ExpandedAlignedText(
                    player?.lastPerformance?.fours.toString() ?? ''),
                ExpandedAlignedText(
                    player?.lastPerformance?.highestScore.toString() ?? ''),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
