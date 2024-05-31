import 'package:flutter/material.dart';

class LiveMatchPlaceholder extends StatelessWidget {
  const LiveMatchPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Placeholder for "At mest"
                  Container(
                    width: 60,
                    height: 10,
                    color: Colors.grey[300],
                  ),
                  const Spacer(),
                  // Placeholder for "Live" tag
                  Container(
                    width: 30,
                    height: 20,
                    color: Colors.grey[400],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  // Placeholder for team icon
                  CircleAvatar(
                    radius: 16.0,
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(width: 8.0),
                  // Placeholder for team name and score
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
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
                  const Spacer(),
                  // Placeholder for score
                  Container(
                    width: 40,
                    height: 10,
                    color: Colors.grey[300],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  // Placeholder for team icon
                  CircleAvatar(
                    radius: 16.0,
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(width: 8.0),
                  // Placeholder for team name and score
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50,
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
                  const Spacer(),
                  // Placeholder for score
                  Container(
                    width: 40,
                    height: 10,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
