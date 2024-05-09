import 'package:flutter/material.dart';

class TestCareerCard extends StatelessWidget {
  const TestCareerCard({super.key});

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
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Career',
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text("Coming Soon"),
          ],
        ),
      ),
    );
  }
}
