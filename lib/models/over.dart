import 'package:cricket_app/models/ball.dart';

class Over {
  final int number;
  final List<Ball> balls;

  Over({
    required this.number,
    required this.balls,
  });

  factory Over.fromJson(Map<String, dynamic> json) {
    return Over(
      number: json['number'] as int,
      balls: (json['balls'] as List<dynamic>)
          .map((ballJson) => Ball.fromJson(ballJson as Map<String, dynamic>))
          .toList(),
    );
  }
}
