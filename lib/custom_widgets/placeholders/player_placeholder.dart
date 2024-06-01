import 'package:flutter/material.dart';

class PlayerPlaceholder extends StatelessWidget {
  const PlayerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Placeholder for profile picture
            CircleAvatar(
              radius: 32.0,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 16.0),
            // Column for name, role, and ID
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 120,
                    height: 10,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    width: 80,
                    height: 10,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 8.0),
                  Container(
                    width: 100,
                    height: 10,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            // Column for action icons
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  color: Colors.grey[300],
                  child: Icon(Icons.edit, color: Colors.grey[400]),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: 24,
                  height: 24,
                  color: Colors.grey[300],
                  child: Icon(Icons.delete, color: Colors.grey[400]),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: 24,
                  height: 24,
                  color: Colors.grey[300],
                  child: Icon(Icons.person_add, color: Colors.grey[400]),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: 24,
                  height: 24,
                  color: Colors.grey[300],
                  child: Icon(Icons.add, color: Colors.grey[400]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
