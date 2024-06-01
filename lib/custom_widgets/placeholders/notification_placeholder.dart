import 'package:flutter/material.dart';

class NotificationPlaceholder extends StatelessWidget {
  const NotificationPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            gradient: LinearGradient(
              colors: [Colors.grey[300]!, Colors.grey[400]!],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Image placeholder
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              const SizedBox(width: 16.0),
              // Text and buttons
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Team label
                    Container(
                      width: 40,
                      height: 10,
                      color: Colors.grey[500],
                    ),
                    const SizedBox(height: 8.0),
                    // Invitation text
                    Container(
                      width: 200,
                      height: 10,
                      color: Colors.grey[500],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16.0),
              // Accept and decline buttons
              Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.check, color: Colors.grey[600]),
                  ),
                  const SizedBox(width: 8.0),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: Colors.grey[500],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, color: Colors.grey[600]),
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
