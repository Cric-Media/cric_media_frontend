import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:flutter/material.dart';

class LiveScorerScreen extends StatefulWidget {
  const LiveScorerScreen({Key? key}) : super(key: key);

  @override
  State<LiveScorerScreen> createState() => _LiveScorerScreenState();
}

class _LiveScorerScreenState extends State<LiveScorerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            //* Innings section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Inning section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Innings',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '1st Inning',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    // score section
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Score',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const Row(
                          children: [Text("0 - 0 (0.0)")],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            //* Batsmen and bowler section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Batsmen section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Batsman',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("R"),
                              SizedBox(width: 20),
                              Text("B"),
                              SizedBox(width: 20),
                              Text("4s"),
                              SizedBox(width: 20),
                              Text("6s"),
                              SizedBox(width: 20),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Wasim Zaman *',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("0"),
                              SizedBox(width: 20),
                              Text("0"),
                              SizedBox(width: 20),
                              Text("0"),
                              SizedBox(width: 20),
                              Text("0"),
                              SizedBox(width: 20),
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Faysal Zaman',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("0"),
                              SizedBox(width: 20),
                              Text("0"),
                              SizedBox(width: 20),
                              Text("0"),
                              SizedBox(width: 20),
                              Text("0"),
                              SizedBox(width: 20),
                            ],
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Bowler section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Bowler',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("O"),
                              SizedBox(width: 20),
                              Text("M"),
                              SizedBox(width: 20),
                              Text("R"),
                              SizedBox(width: 20),
                              Text("W"),
                              SizedBox(width: 20),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Faysal Zaman',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("0"),
                              SizedBox(width: 20),
                              Text("0"),
                              SizedBox(width: 20),
                              Text("0"),
                              SizedBox(width: 20),
                              Text("0"),
                              SizedBox(width: 20),
                            ],
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            //* This over section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    // Over section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'This Over:',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Expanded(
                          child: Wrap(
                            children: ['2', '3', '4', '5', '6', '7']
                                .map((e) => Container(
                                      margin: const EdgeInsets.only(left: 8),
                                      // padding: const EdgeInsets.all(4),
                                      child: CircleAvatar(
                                        child: Text(e),
                                      ),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 5),
            //* Action buttons
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: [
                    Column(
                      children: [
                        Checkbox(
                          value: MatchCubit.get(context).wide ?? false,
                          onChanged: (value) {},
                        ),
                        Text('Wide'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
