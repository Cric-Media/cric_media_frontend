import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StartMatchScreen extends StatefulWidget {
  final MatchDetails match;
  const StartMatchScreen({super.key, required this.match});

  @override
  State<StartMatchScreen> createState() => _StartMatchScreenState();
}

class _StartMatchScreenState extends State<StartMatchScreen> {
  @override
  void initState() {
    MatchCubit.get(context).team1 = widget.match.team1;
    MatchCubit.get(context).team2 = widget.match.team2;
    setState(() {});
    super.initState();
  }

  late DateTime selectedDateTime =
      DateTime.now(); // Initialize with current time
  bool checkBoxValue = false;
  Future<void> _selectDateAndTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        // Combine the selected date and time
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Format the selected date and time
        String formattedDateTime =
            DateFormat('EEEE, MMMM d, y - HH:mm').format(selectedDateTime);

        setState(() {
          MatchCubit.get(context).matchDateTime = formattedDateTime;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Calculate the starting position for the first container to ensure spacing
    // The formula considers container width (100) and desired space (20) to evenly distribute them
    const double containerWidth = 100;
    const double spaceBetween = 150; // Desired space between the containers
    const double totalWidthNeeded = (containerWidth * 2) + spaceBetween;
    final double startingLeftPosition = (screenWidth - totalWidthNeeded) / 2;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColor.blueColor,
        title: const Text(
          'Add Match',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: 60,
              color: AppColor.blueColor,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: screenWidth,
                  height: 100,
                  color: Colors.grey.shade300,
                ),
                SelectTeamWidget(
                  startingLeftPosition: startingLeftPosition,
                  containerWidth: containerWidth,
                  spaceBetween: spaceBetween,
                  teamNo: 1,
                ),
                Positioned(
                  top: -15,
                  right: 130,
                  left: startingLeftPosition + containerWidth,
                  // Position it after the first container + space
                  child: Container(
                    alignment: Alignment.center,
                    width: 35,
                    height: 40,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: const Text(
                      'Vs',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                SelectTeamWidget(
                  startingLeftPosition: startingLeftPosition,
                  containerWidth: containerWidth,
                  spaceBetween: spaceBetween,
                  teamNo: 2,
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              width: screenWidth,
              height: screenHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(children: [
                  const SizedBox(height: 5),
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     'Match Type',
                  //     style: GoogleFonts.inter(
                  //         textStyle: TextStyle(
                  //             fontSize: screenWidth * 0.038,
                  //             fontWeight: FontWeight.w800,
                  //             color: AppColor.blackColor)),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // DropdownWidget(
                  //   items: const [
                  //     'Limited Over',
                  //     'Test Match',
                  //     'Box Cricket',
                  //     'Pair Cricket',
                  //     'The Hundred'
                  //   ],
                  //   value: MatchCubit.get(context).matchType,
                  //   hint: "Select a match type please.",
                  //   onChanged: (v) {
                  //     setState(() {
                  //       MatchCubit.get(context).matchType = v;
                  //     });
                  //   },
                  // ),
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     'Ball Type',
                  //     style: GoogleFonts.inter(
                  //         textStyle: TextStyle(
                  //       fontSize: screenWidth * 0.038,
                  //       fontWeight: FontWeight.w800,
                  //       color: AppColor.blackColor,
                  //     )),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // DropdownWidget(
                  //   items: const [
                  //     'Hard Ball',
                  //     'Tennis Ball',
                  //     'Other',
                  //   ],
                  //   value: MatchCubit.get(context).ballType,
                  //   hint: "Select a ball type please.",
                  //   onChanged: (v) {
                  //     setState(() {
                  //       MatchCubit.get(context).ballType = v;
                  //     });
                  //   },
                  // ),
                  // Align(
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     'Pitch Type ',
                  //     style: GoogleFonts.inter(
                  //         textStyle: TextStyle(
                  //             fontSize: screenWidth * 0.038,
                  //             fontWeight: FontWeight.w800,
                  //             color: AppColor.blackColor)),
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // DropdownWidget(
                  //   items: const [
                  //     'Green pitch',
                  //     'Flat pitch',
                  //     'Dry pitch',
                  //     'Dusty pitch',
                  //     'Grassless pitch',
                  //     'Spinner-friendly pitch',
                  //     'Bouncy pitch',
                  //     'Seaming pitch',
                  //   ],
                  //   value: MatchCubit.get(context).pitchType,
                  //   hint: "Select a pitch type please.",
                  //   onChanged: (v) {
                  //     setState(() {
                  //       MatchCubit.get(context).pitchType = v;
                  //     });
                  //   },
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                  // Row(
                  //   children: [
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Text(
                  //           'Number of over ',
                  //           style: TextStyle(
                  //             fontSize: 15,
                  //             color: AppColor.hintColor,
                  //           ),
                  //         ),
                  //         Container(
                  //             width: 180,
                  //             height: 50,
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(8),
                  //                 color: Colors.grey.withOpacity(0.3)),
                  //             child: TextField(
                  //               onChanged: (value) {
                  //                 MatchCubit.get(context).numberOfOvers =
                  //                     int.tryParse(value);
                  //               },
                  //               keyboardType: TextInputType.number,
                  //               decoration: InputDecoration(
                  //                   hintText: '10',
                  //                   hintStyle: TextStyle(
                  //                     fontSize: 20,
                  //                     color:
                  //                         AppColor.hintColor.withOpacity(0.5),
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //                   contentPadding: const EdgeInsets.symmetric(
                  //                       horizontal: 10),
                  //                   border: InputBorder.none),
                  //             ))
                  //       ],
                  //     ),
                  //     const SizedBox(
                  //       width: 20,
                  //     ),
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Text(
                  //           'Over  per  bowler ',
                  //           style: TextStyle(
                  //             fontSize: 15,
                  //             color: AppColor.hintColor,
                  //           ),
                  //         ),
                  //         Container(
                  //           width: 180,
                  //           height: 50,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(8),
                  //               color: Colors.grey.withOpacity(0.3)),
                  //           child: TextField(
                  //             onChanged: (value) {
                  //               MatchCubit.get(context).oversPerBowler =
                  //                   int.tryParse(value);
                  //             },
                  //             keyboardType: TextInputType.number,
                  //             decoration: InputDecoration(
                  //                 hintText: '10',
                  //                 hintStyle: TextStyle(
                  //                   fontSize: 20,
                  //                   color: AppColor.hintColor.withOpacity(0.5),
                  //                   fontWeight: FontWeight.w500,
                  //                 ),
                  //                 contentPadding: const EdgeInsets.symmetric(
                  //                     horizontal: 10),
                  //                 border: InputBorder.none),
                  //           ),
                  //         )
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(height: 5),
                  // Row(
                  //   children: [
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Text(
                  //           'City / Town ',
                  //           style: TextStyle(
                  //             fontSize: 15,
                  //             color: AppColor.hintColor,
                  //           ),
                  //         ),
                  //         Container(
                  //             width: 180,
                  //             height: 50,
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(8),
                  //                 color: Colors.grey.withOpacity(0.3)),
                  //             child: TextField(
                  //               onChanged: (value) {
                  //                 MatchCubit.get(context).cityTown = value;
                  //               },
                  //               decoration: InputDecoration(
                  //                   hintText: 'Kabul',
                  //                   hintStyle: TextStyle(
                  //                     fontSize: 20,
                  //                     color:
                  //                         AppColor.hintColor.withOpacity(0.5),
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //                   contentPadding: const EdgeInsets.symmetric(
                  //                       horizontal: 10),
                  //                   border: InputBorder.none),
                  //             ))
                  //       ],
                  //     ),
                  //     const SizedBox(
                  //       width: 20,
                  //     ),
                  //     Column(
                  //       mainAxisAlignment: MainAxisAlignment.start,
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         const Text(
                  //           'Ground ',
                  //           style: TextStyle(
                  //             fontSize: 15,
                  //             color: AppColor.hintColor,
                  //           ),
                  //         ),
                  //         Container(
                  //             width: 180,
                  //             height: 50,
                  //             decoration: BoxDecoration(
                  //                 borderRadius: BorderRadius.circular(8),
                  //                 color: Colors.grey.withOpacity(0.3)),
                  //             child: TextField(
                  //               onChanged: (value) {
                  //                 MatchCubit.get(context).ground = value;
                  //               },
                  //               decoration: InputDecoration(
                  //                   hintText: 'Ground',
                  //                   hintStyle: TextStyle(
                  //                     fontSize: 20,
                  //                     color:
                  //                         AppColor.hintColor.withOpacity(0.5),
                  //                     fontWeight: FontWeight.w500,
                  //                   ),
                  //                   contentPadding: const EdgeInsets.symmetric(
                  //                       horizontal: 10),
                  //                   border: InputBorder.none),
                  //             ))
                  //       ],
                  //     )
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // const Align(
                  //   alignment: Alignment.topLeft,
                  //   child: Text(
                  //     'Match Date and Time',
                  //     style: TextStyle(
                  //       fontSize: 16,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w500,
                  //     ),
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // GestureDetector(
                  //   onTap: () {
                  //     _selectDateAndTime(context);
                  //   },
                  //   child: Row(
                  //     children: [
                  //       const Icon(
                  //         Icons.timer,
                  //         color: Colors.black,
                  //       ),
                  //       const SizedBox(width: 10),
                  //       Text(
                  //         MatchCubit.get(context).matchDateTime == null
                  //             ? 'Select time'
                  //             : 'Selected: ${MatchCubit.get(context).matchDateTime.toString()}',
                  //         style: const TextStyle(
                  //             fontSize: 15, color: Colors.black),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Who won the toss',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // or MainAxisAlignment.spaceBetween
                      children: [
                        Checkbox(
                          value: MatchCubit.get(context).teamAToss ?? false,
                          onChanged: (value) {
                            setState(() {
                              MatchCubit.get(context).teamAToss = value!;
                              MatchCubit.get(context).teamBToss = !value;
                            });
                          },
                        ),
                        Text(
                          widget.match.team1?.name ?? 'Team 1',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // or MainAxisAlignment.spaceBetween
                      children: [
                        Checkbox(
                          value: MatchCubit.get(context).teamBToss ?? false,
                          onChanged: (value) {
                            setState(() {
                              MatchCubit.get(context).teamBToss = value!;
                              MatchCubit.get(context).teamAToss = !value;
                            });
                          },
                        ),
                        Text(
                          widget.match.team2?.name ?? 'Team 2',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Toss Details',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.blackColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 3),
                  SizedBox(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // or MainAxisAlignment.spaceBetween
                      children: [
                        Checkbox(
                          value: MatchCubit.get(context).teamABat ?? false,
                          onChanged: (value) {
                            setState(() {
                              MatchCubit.get(context).teamABat = value!;
                              MatchCubit.get(context).teamBBat = !value;
                              MatchCubit.get(context).teamABowl = !value;
                              MatchCubit.get(context).teamBBowl = value;
                            });
                          },
                        ),
                        Text(
                          '${widget.match.team1?.name} Batting',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: MatchCubit.get(context).teamBBat ?? false,
                          onChanged: (value) {
                            setState(() {
                              MatchCubit.get(context).teamBBat = value!;
                              MatchCubit.get(context).teamABat = !value;
                              MatchCubit.get(context).teamBBowl = !value;
                              MatchCubit.get(context).teamABowl = value;
                            });
                          },
                        ),
                        Text(
                          '${widget.match.team2?.name} Batting',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: BlocConsumer<MatchCubit, MatchState>(
                      listener: (context, state) {
                        if (state is MatchStartLoading) {
                        } else if (state is MatchStartSuccess) {
                          showSnack(context, message: state.res.message);
                          Navigator.pop(context);
                        }
                        if (state is MatchStartError) {
                          showSnack(context, message: state.message);
                        }
                      },
                      builder: (context, state) {
                        if (state is MatchStartLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () {
                            MatchCubit.get(context).startMatch(
                              widget.match.sId.toString(),
                            );
                          },
                          child: const Text('Start Match'),
                        );
                      },
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTeamWidget extends StatefulWidget {
  const SelectTeamWidget({
    super.key,
    required this.startingLeftPosition,
    required this.teamNo,
    required this.containerWidth,
    required this.spaceBetween,
  });

  final double startingLeftPosition, containerWidth, spaceBetween;
  final int teamNo;

  @override
  State<SelectTeamWidget> createState() => _SelectTeamWidgetState();
}

class _SelectTeamWidgetState extends State<SelectTeamWidget> {
  late MatchCubit matchCubit;
  late PlayerCubit playerCubit;

  // CONSTANTS

  @override
  void initState() {
    super.initState();
    matchCubit = MatchCubit.get(context);
    playerCubit = PlayerCubit.get(context);
    BlocProvider.of<TeamCubit>(context).getInitialTeams();
  }

  teamsSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: <Widget>[
              Container(
                height: 50,
                width: double.infinity,
                color: AppColor.blueColor,
                child: const Center(
                  child: Text(
                    'Select Team',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Expanded(
                child: BlocConsumer<TeamCubit, TeamState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is TeamGetInitialLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is TeamGetInitial) {
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        itemCount: state.response.data.length,
                        itemBuilder: (context, index) {
                          Team team = state.response.data[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(team.image ?? ''),
                            ),
                            title: Text(team.name.toString()),
                            trailing: TextButton(
                              onPressed: () {
                                if (widget.teamNo == 1) {
                                  matchCubit.team1 = team;
                                } else {
                                  matchCubit.team2 = team;
                                }
                                setState(() {});
                                Navigator.pop(context);
                              },
                              child: const Text("Select"),
                            ),
                          );
                        },
                      );
                    }

                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text('Team $index'),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        });
  }

  playersSheet(String teamId) {
    playerCubit.getPlayersByTeamId(teamId);

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      shape: const RoundedRectangleBorder(),
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<PlayerCubit, PlayerState>(
              listener: (context, state) {
                if (state is PlayerGetInitial) {
                  matchCubit.playerList = state.response.data;
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Select 11 players into your squad.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      flex: 4,
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            if (widget.teamNo == 1) {
                              if (!matchCubit.squad1
                                  .contains(matchCubit.playerList[index])) {
                                print(
                                    'Adding player ${matchCubit.playerList[index].name} to squad1');
                                matchCubit.squad1
                                    .add(matchCubit.playerList[index]);
                              } else {
                                print(
                                    'Player ${matchCubit.playerList[index].name} is already in squad1');
                              }
                            } else {
                              if (!matchCubit.squad2
                                  .contains(matchCubit.playerList[index])) {
                                print(
                                    'Adding player ${matchCubit.playerList[index].name} to squad2');
                                matchCubit.squad2
                                    .add(matchCubit.playerList[index]);
                              } else {
                                print(
                                    'Player ${matchCubit.playerList[index].name} is already in squad2');
                              }
                            }
                            playerCubit.getPlayersByTeamId(teamId);
                          },
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage: CachedNetworkImageProvider(
                                    matchCubit.playerList[index].imageUrl ??
                                        ''),
                              ),
                              Text(matchCubit.playerList[index].name ?? ''),
                            ],
                          ),
                        ),
                        itemCount: matchCubit.playerList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: widget.teamNo == 1
                            ? matchCubit.squad1.length
                            : matchCubit.squad2.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          var player = widget.teamNo == 1
                              ? matchCubit.squad1.elementAt(index)
                              : matchCubit.squad2.elementAt(index);
                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  radius: 35,
                                  backgroundImage: CachedNetworkImageProvider(
                                    player.imageUrl ?? '',
                                  ),
                                ),
                                Positioned(
                                  right: -10,
                                  child: CloseButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      if (widget.teamNo == 1) {
                                        matchCubit.squad1.remove(player);
                                      } else {
                                        matchCubit.squad2.remove(player);
                                      }
                                      playerCubit.getPlayersByTeamId(teamId);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Done'),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var team = widget.teamNo == 1
        ? MatchCubit.get(context).team1
        : MatchCubit.get(context).team2;

    return Positioned(
      top: -30,
      left: widget.teamNo == 1
          ? widget.startingLeftPosition
          : widget.startingLeftPosition +
              widget.containerWidth +
              widget.spaceBetween,
      right: widget.teamNo == 1 ? null : 10,
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              // teamsSheet();
            },
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                image: team != null
                    ? DecorationImage(
                        image: NetworkImage(team.image ?? ''),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(image: AssetImage(AppIcons.profile9)),
                border: Border.all(color: AppColor.blueColor, width: 2),
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
          ),
          Text(
            team?.name ?? 'Team Name',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          GestureDetector(
            onTap: () {
              playersSheet(team?.id ?? '');
            },
            child: Container(
              alignment: Alignment.center,
              width: 120,
              height: 40,
              decoration: BoxDecoration(
                color: AppColor.blueColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Choose squad',
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
