import 'package:country_state_city/models/country.dart';
import 'package:country_state_city/utils/country_utils.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/custom_widgets/dropdown_widget.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/models/tournament.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddTournamentMatchScreen extends StatefulWidget {
  final Tournament tournament;
  final String? groupId;
  final int? totalMatches;
  final String? matchType;
  const AddTournamentMatchScreen({
    super.key,
    required this.tournament,
    this.groupId,
    this.totalMatches,
    this.matchType,
  });

  @override
  State<AddTournamentMatchScreen> createState() =>
      _AddTournamentMatchScreenState();
}

class _AddTournamentMatchScreenState extends State<AddTournamentMatchScreen> {
  List<Country> countries = [];
  late DateTime selectedDateTime = DateTime.now();
  bool checkBoxValue = false;

  @override
  void initState() {
    super.initState();
    MatchCubit.get(context).numberOfOvers = widget.tournament.numberOfOvers;
    getAllCountries().then((value) {
      setState(() {
        countries = value;
      });
    });
  }

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
          'Add Tournament Match',
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
                  tournament: widget.tournament,
                  groupId: widget.groupId,
                  matchType: widget.matchType,
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
                  tournament: widget.tournament,
                  groupId: widget.groupId,
                  matchType: widget.matchType,
                ),
              ],
            ),
            const SizedBox(height: 10),
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
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Match Type',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownWidget(
                    items: const [
                      'Limited Over',
                      'Test Match',
                      'Box Cricket',
                      'Pair Cricket',
                      'The Hundred'
                    ],
                    value: MatchCubit.get(context).matchType,
                    hint: "Select a match type please.",
                    onChanged: (v) {
                      setState(() {
                        MatchCubit.get(context).matchType = v;
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Ball Type',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                        fontSize: screenWidth * 0.038,
                        fontWeight: FontWeight.w800,
                        color: AppColor.blackColor,
                      )),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownWidget(
                    items: const [
                      'Hard Ball',
                      'Tennis Ball',
                      'Other',
                    ],
                    value: MatchCubit.get(context).ballType,
                    hint: "Select a ball type please.",
                    onChanged: (v) {
                      setState(() {
                        MatchCubit.get(context).ballType = v;
                      });
                    },
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Pitch Type ',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownWidget(
                    items: const [
                      'Green pitch',
                      'Flat pitch',
                      'Dry pitch',
                      'Dusty pitch',
                      'Grassless pitch',
                      'Spinner-friendly pitch',
                      'Bouncy pitch',
                      'Seaming pitch',
                    ],
                    value: MatchCubit.get(context).pitchType,
                    hint: "Select a pitch type please.",
                    onChanged: (v) {
                      setState(() {
                        MatchCubit.get(context).pitchType = v;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Number of overs',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColor.hintColor,
                              ),
                            ),
                            Container(
                                width: 180,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.withOpacity(0.3)),
                                child: TextField(
                                  onChanged: (value) {
                                    MatchCubit.get(context).numberOfOvers =
                                        int.tryParse(value);
                                  },
                                  controller: TextEditingController(
                                    text: MatchCubit.get(context)
                                        .numberOfOvers
                                        .toString(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: '10',
                                      hintStyle: TextStyle(
                                        fontSize: 20,
                                        color:
                                            AppColor.hintColor.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      border: InputBorder.none),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Over  per  bowler ',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColor.hintColor,
                              ),
                            ),
                            Container(
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(0.3)),
                              child: TextField(
                                onChanged: (value) {
                                  MatchCubit.get(context).oversPerBowler =
                                      int.tryParse(value);
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    hintText: '10',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color:
                                          AppColor.hintColor.withOpacity(0.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    border: InputBorder.none),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'City / Town ',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColor.hintColor,
                              ),
                            ),
                            Container(
                                width: 180,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.withOpacity(0.3)),
                                child: TextField(
                                  onChanged: (value) {
                                    MatchCubit.get(context).cityTown = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Kabul',
                                      hintStyle: TextStyle(
                                        fontSize: 20,
                                        color:
                                            AppColor.hintColor.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      border: InputBorder.none),
                                ))
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Ground ',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColor.hintColor,
                              ),
                            ),
                            Container(
                                width: 180,
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Colors.grey.withOpacity(0.3)),
                                child: TextField(
                                  onChanged: (value) {
                                    MatchCubit.get(context).ground = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Ground',
                                      hintStyle: TextStyle(
                                        fontSize: 20,
                                        color:
                                            AppColor.hintColor.withOpacity(0.5),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 10),
                                      border: InputBorder.none),
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Match Date and Time',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  GestureDetector(
                    onTap: () {
                      _selectDateAndTime(context);
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.timer,
                          color: Colors.black,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          MatchCubit.get(context).matchDateTime == null
                              ? 'Select time'
                              : 'Selected: ${MatchCubit.get(context).matchDateTime.toString()}',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Country',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  DropdownWidget(
                    items: countries.map((e) => e.name).toList(),
                    value: MatchCubit.get(context).country,
                    hint: "Select a country please.",
                    onChanged: (v) {
                      setState(() {
                        MatchCubit.get(context).country = v;
                      });
                    },
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: BlocConsumer<MatchCubit, MatchState>(
                      listener: (context, state) {
                        if (state is MatchAddDetailsLoading) {
                          // AppDialogs.loadingDialog(context);
                        } else if (state is MatchAddDetailsSuccess) {
                          // AppDialogs.closeDialog(context);
                          // Navigator.pop(context);
                          showSnack(context, message: state.res.message);
                          TournamentCubit.get(context).upComingMatches();
                          Navigator.pop(context);
                        }
                        if (state is MatchAddDetailsError) {
                          // AppDialogs.closeDialog(context);
                          showSnack(context, message: state.message);
                        }
                      },
                      builder: (context, state) {
                        if (state is MatchAddDetailsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () {
                            MatchCubit.get(context).addMatchDetails(
                              tournamentId: widget.tournament.sId,
                              tournamentMatchType: TournamentCubit.get(context)
                                  .selectedMatchType,
                              groupId: widget.groupId,
                              totalMatches: widget.totalMatches,
                            );
                          },
                          child: const Text('Create new match'),
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
    required this.tournament,
    this.groupId,
    this.matchType,
  });

  final double startingLeftPosition, containerWidth, spaceBetween;
  final int teamNo;
  final Tournament tournament;
  final String? groupId;
  final String? matchType;

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
                      List<Team> teams = [];
                      if (widget.groupId != null) {
                        int groupIndex = -1;
                        groupIndex = widget.tournament.groups!.indexWhere(
                          (group) => group.id == widget.groupId,
                        );

                        if (groupIndex != -1) {
                          teams = state.response.data;
                          // teams = widget.tournament.groups![groupIndex].teams!;
                          teams = widget.tournament.groups![groupIndex].teams!
                              .map(
                                (team) => team.team!,
                              )
                              .toList();
                        } else {
                          // teams = widget.tournament.teams!
                          //     .map((t) => t.team!)
                          //     .toList();
                          teams = state.response.data;
                        }
                      } else {
                        if (widget.matchType == 'semiFinal') {
                          teams = widget.tournament.teams!
                              .where(
                                (t) {
                                  return widget.tournament.semiFinalTeams!
                                      .contains(t.team?.id);
                                },
                              )
                              .map((t) => t.team!)
                              .toList();
                        } else if (widget.matchType == 'final') {
                          teams = widget.tournament.teams!
                              .where(
                                (t) {
                                  return widget.tournament.finalTeams!
                                      .contains(t.team?.id);
                                },
                              )
                              .map((t) => t.team!)
                              .toList();
                        } else {
                          teams = widget.tournament.teams!
                              .map((t) => t.team!)
                              .toList();
                        }
                        // teams = state.response.data;
                      }
                      return ListView.separated(
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                        // itemCount: state.response.data.length,
                        // itemCount: widget.tournament.teams?.length ?? 0,
                        itemCount: teams.length,
                        itemBuilder: (context, index) {
                          // Team team = state.response.data[index];

                          // If match is series match then...
                          Team team = teams[index];
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

                    return Container();
                  },
                ),
              ),
            ],
          );
        });
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
              teamsSheet();
            },
            child: Container(
              width: 100,
              height: 100,
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
            team?.name ?? 'Team ${widget.teamNo == 1 ? 1 : 2}',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}