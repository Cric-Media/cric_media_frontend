import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/admin/admin_cubit.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/custom_widgets/placeholders/player_placeholder.dart';
import 'package:cricket_app/models/admin.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/utils/app_dialog.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_listview/searchable_listview.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  List<Team> teams = [];

  @override
  void initState() {
    TeamCubit.get(context).getInitialTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          // extra container for custom bottom shadows
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.blueColor,
            automaticallyImplyLeading: true,
            title: Text(
              'Teams',
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      body: BlocConsumer<TeamCubit, TeamState>(listener: (context, state) {
        if (state is TeamGetInitial) {
          teams = state.response.data;
        } else if (state is TeamGetError) {
        } else if (state is TeamDeleteLoading) {
          AppDialogs.loadingDialog(context);
        } else if (state is TeamDeleteError) {
          Navigator.pop(context);
          showSnack(context, message: state.message);
        } else if (state is TeamDeleteSuccess) {
          Navigator.pop(context);
          if (teams.length == 1) {
            teams = [];
          }
          TeamCubit.get(context).getInitialTeams();
        } else if (state is TeamAddPlayerLoading) {
          AppDialogs.loadingDialog(context);
        } else if (state is TeamAddPlayerSuccess) {
          AppDialogs.closeDialog(context);
          TeamCubit.get(context).getInitialTeams();
        } else if (state is TeamAddPlayerError) {
          AppDialogs.closeDialog(context);
          showSnack(context, message: state.message);
        }
      }, builder: (context, state) {
        if (state is TeamGetInitialLoading) {
          return ListView.builder(
            itemBuilder: (context, index) => const PlayerPlaceholder(),
            itemCount: 6,
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchableList(
            // autoCompleteHints: teams.map((e) => e.name.toString()).toList(),
            searchFieldEnabled: true,
            closeKeyboardWhenScrolling: true,
            inputDecoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            initialList: teams,
            filter: (query) {
              return teams
                  .where((team) =>
                      team.name!.toLowerCase().contains(query.toLowerCase()))
                  .toList();
            },
            itemBuilder: (item) => Container(
                margin: const EdgeInsets.only(bottom: 16),
                child: TeamTile(team: item)),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            addTeam,
            arguments: {'team': null},
          );
        },
        backgroundColor: AppColor.blueColor,
        child: const Icon(
          Icons.add,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}

class TeamTile extends StatefulWidget {
  final Team team;
  const TeamTile({Key? key, required this.team}) : super(key: key);

  @override
  State<TeamTile> createState() => _TeamTileState();
}

class _TeamTileState extends State<TeamTile> {
  List<Admin> admins = [];
  List<Player> playerList = [];
  String search = '';

  // Cubits
  PlayerCubit playerCubit = PlayerCubit();
  late TeamCubit teamCubit;
  // Scroll controller
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  int limit = 20;

  @override
  void initState() {
    teamCubit = TeamCubit.get(context);
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

  adminsSheet(BuildContext context) {
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
                  } else if (state is AdminShareSuccess) {
                    Navigator.pop(context);
                    showSnack(context, message: state.response.message);
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
                            // BlocProvider.of<AdminCubit>(context).shareTeam(
                            //   widget.team.id.toString(),
                            //   admins[index].id.toString(),
                            // );
                            AdminCubit.get(context).shareAccess(
                              id: widget.team.id.toString(),
                              adminId: admins[index].id.toString(),
                              type: 'team',
                            );
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

  playersSheet() {
    playerCubit.getPlayersByAdminId();
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
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BlocConsumer<PlayerCubit, PlayerState>(
              bloc: playerCubit,
              listener: (context, state) {
                if (state is PlayerGetInitial) {
                  playerList = state.response.data;
                }
              },
              builder: (context, state) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SearchableList(
                        searchFieldEnabled: true,
                        closeKeyboardWhenScrolling: true,
                        inputDecoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        initialList: playerList,
                        filter: (query) {
                          return playerList
                              .where((team) => team.name!
                                  .toLowerCase()
                                  .contains(query.toLowerCase()))
                              .toList();
                        },
                        itemBuilder: (item) => ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: CachedNetworkImageProvider(
                              item.imageUrl ?? '',
                            ),
                          ),
                          title: Text(item.name ?? ''),
                          subtitle: Text(item.role ?? ''),
                          trailing: ElevatedButton(
                            onPressed: () {
                              teamCubit.addPlayerToTeam(
                                widget.team.id.toString(),
                                item.id.toString(),
                              );
                            },
                            child: const Text("Add"),
                          ),
                        ),
                      ),
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
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          teamPlayers,
          arguments: {'teamId': widget.team.id.toString()},
        );
      },
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        height: 75,
                        width: 75,
                        child: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                              widget.team.image ?? ''),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 12,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    widget.team.name ?? '',
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            fontSize: 16,
                                            color: AppColor.blackColor,
                                            fontWeight: FontWeight.w700)),
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    'ID:${widget.team.id?.substring(0, 7)}',
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                            fontSize: 15,
                                            color: AppColor.blackColor,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Text(
                                    'Total players:${widget.team.players?.length}',
                                    style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                      fontSize: 12,
                                      color: AppColor.blackColor,
                                    )),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: GestureDetector(
                                    onTap: () {
                                      adminsSheet(context);
                                    },
                                    child: Row(
                                      children: [
                                        const Text("Share access"),
                                        const SizedBox(width: 10),
                                        Image.asset(
                                          'assets/image/invite.png',
                                          width: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        addTeam,
                                        arguments: {'team': widget.team},
                                      );
                                    },
                                    child:
                                        Image.asset(AppIcons.edit, width: 20),
                                  ),
                                  const SizedBox(height: 15),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<TeamCubit>(context)
                                          .deleteTeam(
                                        widget.team.id.toString(),
                                      );
                                    },
                                    child:
                                        Image.asset(AppIcons.delete, width: 20),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      playersSheet();
                                    },
                                    child: Image.asset(AppIcons.add, width: 20),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
