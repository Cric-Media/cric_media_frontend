import 'package:flutter/material.dart';

class RecentMatchPlaceholder extends StatelessWidget {
  const RecentMatchPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side of the card
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Placeholder for match title
                    Container(
                      width: 180,
                      height: 10,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16.0,
                          backgroundColor: Colors.grey[300],
                        ),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 10,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 4.0),
                              Container(
                                width: 40,
                                height: 10,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
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
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 100,
                                height: 10,
                                color: Colors.grey[300],
                              ),
                              const SizedBox(height: 4.0),
                              Container(
                                width: 40,
                                height: 10,
                                color: Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      width: double.infinity,
                      height: 10,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              // Right side of the card
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Container(
                      width: 80,
                      height: 10,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: 4.0),
                    Container(
                      width: 100,
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
