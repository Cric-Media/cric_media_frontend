import 'package:cricket_app/custom_widgets/live_custom_widget.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';

class Live extends StatelessWidget {
  final MatchDetails? match;
  const Live({super.key, this.match});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 10),
      LiveCustomWidgt(match: match),
      const SizedBox(height: 20),
    ]);
  }
}
