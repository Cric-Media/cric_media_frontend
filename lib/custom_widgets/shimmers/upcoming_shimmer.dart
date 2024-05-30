import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UpcomingShimmer extends StatelessWidget {
  const UpcomingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Card(
          color: Colors.white,
          elevation: 2,
          child: Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 12,
                          width: screenWidth * 0.6,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          color: Colors.grey,
                          height: 12,
                          width: screenWidth * 0.4,
                        ),
                        SizedBox(height: screenHeight * 0.015),
                        Row(
                          children: [
                            Container(
                              color: Colors.grey,
                              width: 35,
                              height: 35,
                            ),
                            const SizedBox(width: 15),
                            Container(
                              color: Colors.grey,
                              height: 13,
                              width: screenWidth * 0.3,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Container(
                              color: Colors.grey,
                              width: 35,
                              height: 35,
                            ),
                            const SizedBox(width: 15),
                            Container(
                              color: Colors.grey,
                              height: 13,
                              width: screenWidth * 0.3,
                            ),
                          ],
                        ),
                        Container(
                          color: Colors.grey,
                          height: 13,
                          width: screenWidth * 0.3,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: const Color(0xffECECEC),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey,
                          width: 80,
                          height: 30,
                        ),
                        const SizedBox(height: 15),
                        Container(
                          color: Colors.grey,
                          height: 12,
                          width: screenWidth * 0.3,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          color: Colors.grey,
                          height: 12,
                          width: screenWidth * 0.2,
                        ),
                        const SizedBox(height: 7),
                        Container(
                          color: Colors.grey,
                          height: 12,
                          width: screenWidth * 0.2,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
