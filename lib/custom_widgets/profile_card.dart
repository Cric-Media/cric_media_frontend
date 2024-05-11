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
            if (player != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: player!.latestPerformance!
                    .map((e) => ExpandedAlignedText(e.team?.name ?? ''))
                    .toList(),
              ),
            if (player != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: player!.latestPerformance!
                    .map((e) => ExpandedAlignedText("Runs:${e.runs ?? 0}"))
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}
