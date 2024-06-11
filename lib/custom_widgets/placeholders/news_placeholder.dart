import 'dart:ui' as ui; // Importing dart:ui for TextDirection

import 'package:flutter/material.dart';

class NewsPlaceholder extends StatelessWidget {
  const NewsPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Directionality(
      textDirection: ui.TextDirection.rtl, // Use TextDirection from dart:ui
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder for the image
              Container(
                width: screenWidth * 0.2,
                height: screenWidth * 0.2,
                color: Colors.grey[300],
              ),
              const SizedBox(width: 16.0),
              // Placeholder for the text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
      ),
    );
  }
}
