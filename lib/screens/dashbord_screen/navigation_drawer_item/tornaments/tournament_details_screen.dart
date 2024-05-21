import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/admin/admin_cubit.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_up_coming_matches_card.dart';
import 'package:cricket_app/custom_widgets/match_details_live_card.dart';
import 'package:cricket_app/custom_widgets/points_table_widget.dart';
import 'package:cricket_app/models/admin.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/models/tournament.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TournamentDetailsScreen extends StatefulWidget {
  final Tournament tournament;
  const TournamentDetailsScreen({Key? key, required this.tournament})
      : super(key: key);

  @override
  State<TournamentDetailsScreen> createState() =>
      _TournamentDetailsScreenState();
}

class _TournamentDetailsScreenState extends State<TournamentDetailsScreen> {
  @override
  void initState() {
    TournamentCubit.get(context).getTournament(widget.tournament.sId ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Hero(
                tag: widget.tournament.sId.toString(),
                child: Container(
                  height: screenHeight * 0.3,
                  width: screenWidth,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          widget.tournament.image ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Tabs controller
              Expanded(
                child: BlocConsumer<TournamentCubit, TournamentState>(
                  listener: (context, state) {
                    if (state is TournamentAddError) {
                      showSnack(context, message: state.message);
                    } else if (state is TournamentGetSuccess) {
                      TournamentCubit.get(context).tournament =
                          state.response.data;
                    }
                  },
                  builder: (context, state) {
                    if (state is TournamentRemoveTeamLoading ||
                        state is TournamentAddTeamLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TournamentGetLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is TournamentAddTeamSuccess ||
                        state is TournamentRemoveTeamSuccess) {
                      TournamentCubit.get(context).getTournament(
                        widget.tournament.sId ?? '',
                      );
                    }
                    return DefaultTabController(
                      length: 7,
                      initialIndex: 0,
                      child: Column(
                        children: [
                          const TabBar(
                            isScrollable: true,
                            tabs: [
                              Tab(text: "Home"),
                              Tab(text: "Teams"),
                              Tab(text: "Groups"),
                              Tab(text: "Up coming"),
                              Tab(text: "Live"),
                              Tab(text: "Completed"),
                              Tab(text: "Points Table"),
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Home(tournament: widget.tournament),
                                Teams(teamsSheet: teamsSheet),
                                const Column(children: []),
                                // Upcoming
                                const Upcoming(),
                                // Live
                                const Live(),
                                // Completed
                                const Column(children: []),
                                // Points Table
                                PointsTableWidget(
                                  tournamentId: widget.tournament.sId ?? '',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Positioned(
            top: 40,
            left: 10,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void teamsSheet() {
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
                                TournamentCubit.get(context).addTeam(
                                  tournamentId:
                                      widget.tournament.sId.toString(),
                                  teamId: team.id.toString(),
                                );
                                Navigator.pop(context);
                              },
                              child: const Text("Select"),
                            ),
                          );
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          );
        });
  }
}

class Home extends StatefulWidget {
  final Tournament tournament;
  const Home({Key? key, required this.tournament}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Admin> admins = [];
  String search = '';
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  int limit = 20;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        BlocProvider.of<AdminCubit>(context).getMoreOtherAdmins(
          search: search,
          page: page,
          limit: limit,
        );
      }
    });
    super.initState();
  }

  void showAdminsSheet(BuildContext context) {
    BlocProvider.of<AdminCubit>(context).getInitialOtherAdmins();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      useSafeArea: true,
      builder: (context) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search Users",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                onChanged: (value) {
                  search = value;
                  BlocProvider.of<AdminCubit>(context).getInitialOtherAdmins(
                    search: search,
                  );
                },
              ),
            ),
            Expanded(
              child: BlocConsumer<AdminCubit, AdminState>(
                listener: (context, state) {
                  if (state is AdminGetOtherAdminsSuccess) {
                    admins = state.response.data;
                  } else if (state is AdminGetOtherMoreAdminsSuccess) {
                    admins.addAll(state.response.data);
                  } else if (state is AdminSharePlayerSuccess) {
                    Navigator.pop(context);
                    showSnack(context, message: state.response.message);
                  } else if (state is AdminShareSuccess) {
                    showSnack(context, message: state.response.message);
                  } else if (state is AdminShareError) {
                    showSnack(context, message: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is AdminLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    controller: _scrollController,
                    itemCount: admins.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            admins[index].imageUrl.toString(),
                          ),
                          onBackgroundImageError: (exception, stackTrace) =>
                              const Icon(Icons.person),
                        ),
                        title: Text(admins[index].name.toString()),
                        trailing: TextButton(
                          onPressed: () {
                            AdminCubit.get(context).shareAccess(
                              id: widget.tournament.sId.toString(),
                              adminId: admins[index].id.toString(),
                              type: "tournament",
                            );
                            Navigator.pop(context);
                          },
                          child: const Text("Share access"),
                        ),
                        // Other properties of ListTile
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void scheduleMatchSheet() {
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
                  'Schedule Match',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            const ScheduleMatchWidget(),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var tournament = TournamentCubit.get(context).tournament;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${tournament?.seriesName}",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text("${tournament?.seriesLocation}"),
                    Text(
                        "${DateFormat.yMMMMd().format(DateTime.parse(tournament!.startDate!))} - ${DateFormat.yMMMMd().format(DateTime.parse(tournament.endDate!))}"),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[300],
                      child: IconButton(
                        icon: const Icon(Icons.share),
                        onPressed: () {
                          showAdminsSheet(context);
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Text("${tournament.tournamentType}"),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: AssetImage(
                          tournament.tournamentType?.toLowerCase() ==
                                  "hard ball"
                              ? "assets/icons/hard_ball.png"
                              : "assets/icons/tennis_ball.png"),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // const Divider(),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ButtonWidget(
                  text: "SCHEDULE MATCH",
                  color: Colors.green[400],
                  onTap: scheduleMatchSheet,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ButtonWidget(
                  text: "CREATE GROUP",
                  color: Colors.blue[400],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class Teams extends StatefulWidget {
  final VoidCallback teamsSheet;
  const Teams({Key? key, required this.teamsSheet}) : super(key: key);

  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                childAspectRatio: 1,
              ),
              itemCount: TournamentCubit.get(context).tournament?.teams?.length,
              itemBuilder: (
                BuildContext context,
                int index,
              ) {
                var team =
                    TournamentCubit.get(context).tournament?.teams?[index];
                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 5.0,
                            spreadRadius: 1.0,
                            offset: Offset(1.0, 1.0),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: CachedNetworkImageProvider(
                          team?.team?.image ?? '',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      team?.team?.name ?? "",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.teamsSheet,
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.indigo[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text("ADD TEAM")),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    deleteTeamSheet(
                      TournamentCubit.get(context).tournament!,
                    );
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(child: Text("REMOVE TEAM")),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void deleteTeamSheet(Tournament tournament) {
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
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: tournament.teams!.length,
                itemBuilder: (context, index) {
                  Team? team = tournament!.teams![index].team;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(team!.image ?? ''),
                    ),
                    title: Text(team!.name.toString()),
                    trailing: TextButton(
                      onPressed: () {
                        TournamentCubit.get(context).removeTeam(
                          tournamentId: TournamentCubit.get(context)
                              .tournament!
                              .sId
                              .toString(),
                          teamId: team.id.toString(),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text("Remove"),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class ScheduleMatchWidget extends StatefulWidget {
  const ScheduleMatchWidget({super.key});

  @override
  State<ScheduleMatchWidget> createState() => _ScheduleMatchWidgetState();
}

class _ScheduleMatchWidgetState extends State<ScheduleMatchWidget> {
  @override
  void initState() {
    TournamentCubit.get(context).selectedMatchType = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //TODO Group Name
            const Text(
              "Select Match Type",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textBaseline: TextBaseline.alphabetic,
                  decoration: TextDecoration.underline),
            ),
            const SizedBox(height: 8),
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      TournamentCubit.get(context).selectedMatchType =
                          TournamentCubit.get(context).matchTypes[index];
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: TournamentCubit.get(context).selectedMatchType ==
                              TournamentCubit.get(context).matchTypes[index]
                          ? Colors.green[300]
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        TournamentCubit.get(context).matchTypes[index],
                      ),
                    ),
                  ),
                );
              },
              itemCount: TournamentCubit.get(context).matchTypes.length,
              shrinkWrap: true,
            ),
            const SizedBox(height: 8),
            if (TournamentCubit.get(context).selectedMatchType != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    addTournamentMatch,
                    arguments: TournamentCubit.get(context).tournament,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blueColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Continue"),
              ),
          ],
        ),
      ),
    );
  }
}

class Upcoming extends StatefulWidget {
  const Upcoming({super.key});

  @override
  State<Upcoming> createState() => _UpcomingState();
}

class _UpcomingState extends State<Upcoming> {
  @override
  void initState() {
    if (TournamentCubit.get(context).upcomingMatchDetailsList.isEmpty) {
      TournamentCubit.get(context).upComingMatches();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TournamentCubit, TournamentState>(
      listener: (context, state) {
        if (state is TournamentUpcomingMatchesSuccess) {
          TournamentCubit.get(context).upcomingMatchDetailsList =
              state.response.data;
        }
      },
      builder: (context, state) {
        if (state is TournamentUpcomingMatchesLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is TournamentUpcomingMatchesError) {
          return Center(
            child: Text(state.message),
          );
        }
        return RefreshIndicator(
          onRefresh: () async {
            TournamentCubit.get(context).upComingMatches();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: TournamentCubit.get(context)
                      .upcomingMatchDetailsList
                      .length,
                  itemBuilder: (ctx, index) {
                    var match = TournamentCubit.get(ctx)
                        .upcomingMatchDetailsList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: UpCommingMachesCard(match: match, admin: true),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Live extends StatefulWidget {
  const Live({super.key});

  @override
  State<Live> createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  void initState() {
    if (TournamentCubit.get(context).liveMatchDetailsList.isEmpty) {
      TournamentCubit.get(context).getLiveMatches();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(children: [
        Expanded(
          child: BlocConsumer<TournamentCubit, TournamentState>(
            listener: (context, state) {
              if (state is TournamentLiveMatchesSuccess) {
                TournamentCubit.get(context).liveMatchDetailsList =
                    state.response.data;
              }
            },
            builder: (context, state) {
              if (state is TournamentLiveMatchesLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TournamentLiveMatchesError) {
                return Center(child: Text(state.message));
              }

              return ListView.builder(
                  itemCount:
                      TournamentCubit.get(context).liveMatchDetailsList.length,
                  itemBuilder: (context, index) {
                    var match = TournamentCubit.get(context)
                        .liveMatchDetailsList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, setOpenings, arguments: {
                            "matchId": match.sId.toString(),
                            "teamABatting": match.team1Batting,
                            "teamBBatting": match.team2Batting,
                            "teamAId": match.team1?.id.toString(),
                            "teamBId": match.team2?.id.toString(),
                            "squad1": match.squad1 ?? [],
                            "squad2": match.squad2 ?? [],
                          });
                        },
                        child: Hero(
                          tag: match.sId.toString(),
                          child: MatchDetailsLiveCard(match: match),
                        ),
                      ),
                    );
                  });
            },
          ),
        ),
        const SizedBox(height: 70)
      ]),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, this.onTap, this.color, required this.text});

  final void Function()? onTap;
  final Color? color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
            child: Text(text, style: const TextStyle(color: Colors.white))),
      ),
    );
  }
}
