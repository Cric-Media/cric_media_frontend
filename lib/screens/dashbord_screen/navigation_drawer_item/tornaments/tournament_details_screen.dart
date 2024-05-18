import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/admin/admin_cubit.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
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
  List<Admin> admins = [];
  String search = '';
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  int limit = 20;

  @override
  void initState() {
    TournamentCubit.get(context).getTournament(widget.tournament.sId ?? '');
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
                          "${widget.tournament.seriesName}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("${widget.tournament.seriesLocation}"),
                        Text(
                            "${DateFormat.yMMMMd().format(DateTime.parse(widget.tournament.startDate!))} - ${DateFormat.yMMMMd().format(DateTime.parse(widget.tournament.endDate!))}"),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        // const Text(
                        //   "Share access",
                        //   style: TextStyle(
                        //     fontSize: 20,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        // const SizedBox(height: 8),
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
                              widget.tournament.tournamentType?.toLowerCase() ==
                                      "hard ball"
                                  ? "assets/icons/hard_ball.png"
                                  : "assets/icons/tennis_ball.png"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
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
                      length: 6,
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
                            ],
                          ),
                          Expanded(
                            child: TabBarView(
                              children: [
                                const Home(),
                                Teams(teamsSheet: teamsSheet),
                                const Column(children: []),
                                const Column(children: []),
                                const Column(children: []),
                                const Column(children: []),
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
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.green[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text("SCHEDULE MATCH")),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(child: Text("CREATE GROUP")),
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
  final teamsSheet;
  const Teams({Key? key, this.teamsSheet}) : super(key: key);

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
                        radius: 40,
                        backgroundImage: CachedNetworkImageProvider(
                          team?.image ?? '',
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      team?.name ?? "",
                      style: const TextStyle(
                        fontSize: 16,
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
                  child: CustomButton(
                buttonText: "Add Team",
                onTap: () {
                  widget.teamsSheet();
                },
              )),
              const SizedBox(width: 16),
              Expanded(
                  child: CustomButton(
                buttonText: "Remove Team",
                onTap: () {
                  deleteTeamSheet(TournamentCubit.get(context).tournament!);
                },
              )),
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
                  Team team = tournament.teams![index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(team.image ?? ''),
                    ),
                    title: Text(team.name.toString()),
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
