import 'package:flutter/material.dart';

class UpcomingMatchPlaceholder extends StatelessWidget {
  const UpcomingMatchPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Left side of the card
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      height: 10,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 150,
                      height: 10,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16.0,
                          backgroundColor: Colors.grey[300],
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          width: 50,
                          height: 10,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16.0,
                          backgroundColor: Colors.grey[300],
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          width: 50,
                          height: 10,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              // Right side of the card
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 60,
                      height: 20,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 100,
                      height: 10,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 120,
                      height: 10,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      width: 80,
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
