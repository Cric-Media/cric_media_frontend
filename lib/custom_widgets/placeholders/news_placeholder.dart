import 'package:flutter/material.dart';

class NewsPlaceholder extends StatelessWidget {
  const NewsPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for the image
            Container(
              width: 60,
              height: 60,
              color: Colors.grey[300],
            ),
            const SizedBox(width: 16.0),
            // Placeholder for the text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Placeholder for the title
                  Container(
                    width: double.infinity,
                    height: 20,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 8.0),
                  // Placeholder for the description
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
