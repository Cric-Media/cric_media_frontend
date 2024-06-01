import 'package:flutter/material.dart';

class TournamentPlaceholder extends StatelessWidget {
  const TournamentPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            // Content overlay
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tournament name placeholder
                  Container(
                    width: 100,
                    height: 10,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 8.0),
                  // Location placeholder
                  Container(
                    width: 50,
                    height: 10,
                    color: Colors.grey[400],
                  ),
                  const Spacer(),
                  // Dates placeholder
                  Container(
                    width: 200,
                    height: 10,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    width: 150,
                    height: 10,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
            // Edit icon placeholder
            Positioned(
              top: 8.0,
              right: 8.0,
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey[400],
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.edit, color: Colors.grey[500]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
