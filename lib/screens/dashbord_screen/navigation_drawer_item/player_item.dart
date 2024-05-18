import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/admin/admin_cubit.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/models/admin.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/profile_Screen/player_profile_screen.dart';
import 'package:cricket_app/utils/app_dialog.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlayerItem extends StatefulWidget {
  const PlayerItem({super.key});

  @override
  State<PlayerItem> createState() => _PlayerItemState();
}

class _PlayerItemState extends State<PlayerItem> {
  List<Player> players = [];
  @override
  void initState() {
    BlocProvider.of<PlayerCubit>(context).getPlayersByAdminId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      appBar: AppBar(
        title: const Text("Players"),
        backgroundColor: AppColor.blueColor,
        foregroundColor: Colors.white,
      ),
      body: BlocConsumer<PlayerCubit, PlayerState>(
        listener: (context, state) {
          if (state is PlayerGetInitial) {
            players = state.response.data;
          } else if (state is PlayerDeleteLoading) {
            AppDialogs.loadingDialog(context);
          } else if (state is PlayerDeleteSuccess) {
            Navigator.pop(context);
            BlocProvider.of<PlayerCubit>(context).getPlayersByAdminId();
          } else if (state is PlayerDeleteError) {
            Navigator.pop(context);
            showSnack(context, message: state.message);
          }
        },
        builder: (context, state) {
          if (state is PlayerGetInitialLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PlayerEmptyState) {
            return const Center(
              child: Text("No Players Found"),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: players.length,
                  // Adjusted for simplicity
                  itemBuilder: (context, index) {
                    return PlayerTile(player: players[index]);
                  },
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            addNewPlayer,
            arguments: {"playerId": null},
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

class PlayerTile extends StatefulWidget {
  final Player player;
  const PlayerTile({
    super.key,
    required this.player,
  });

  @override
  State<PlayerTile> createState() => _PlayerTileState();
}

class _PlayerTileState extends State<PlayerTile> {
  List<Admin> admins = [];
  List<Team> teams = [];
  String search = '';

  // Scroll controller
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

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(bottom: 10),
      color: Colors.grey.shade100,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        PlayerProfileScreen(id: widget.player.id),
                  ),
                );
              },
              child: Hero(
                tag: widget.player.id.toString(),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: CachedNetworkImageProvider(
                    widget.player.imageUrl.toString(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // name
                Text(
                  widget.player.name.toString(),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                // role
                Text("Role: ${widget.player.role}"),
                // id
                Row(
                  children: [
                    Text("ID: ${widget.player.id!.substring(0, 7)}"),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        showAdminsSheet(context);
                      },
                      icon: const Icon(
                        Icons.person_add_alt,
                        color: AppColor.blueColor,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, addNewPlayer,
                      arguments: {"playerId": widget.player.id!});
                },
                icon: const Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  AppDialogs.showConfirmationDialog(context,
                      title: "Delete Player?",
                      message: "Do you really want to delete this player?",
                      onPressed: () {
                    BlocProvider.of<PlayerCubit>(context)
                        .deletePlayer(widget.player.id!);
                  });
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
              IconButton(
                onPressed: () {
                  showTeams(context);
                },
                icon: const Icon(Icons.add_circle_outline_outlined),
              ),
            ],
          )),
        ],
      ),
    );
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
                            // BlocProvider.of<AdminCubit>(context).sharePlayer(
                            //   playerId: widget.player.id.toString(),
                            //   adminId: admins[index].id.toString(),
                            // );
                            AdminCubit.get(context).shareAccess(
                              id: widget.player.id.toString(),
                              adminId: admins[index].id.toString(),
                              type: 'player',
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

  void showTeams(BuildContext context) {
    BlocProvider.of<TeamCubit>(context).getInitialTeams();

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
                  // BlocProvider.of<AdminCubit>(context).getInitialOtherAdmins(
                  //   search: search,
                  // );
                },
              ),
            ),
            Expanded(
              child: BlocConsumer<TeamCubit, TeamState>(
                listener: (context, state) {
                  if (state is TeamGetInitial) {
                    teams = state.response.data;
                  } else if (state is TeamAddPlayerLoading) {
                    AppDialogs.loadingDialog(context);
                  } else if (state is TeamAddPlayerSuccess) {
                    Navigator.pop(context);
                    showSnack(context, message: state.response.message);
                  } else if (state is TeamAddPlayerError) {
                    Navigator.pop(context);
                    showSnack(context, message: state.message);
                  }
                },
                builder: (context, state) {
                  if (state is TeamGetInitialLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    itemCount: teams.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            teams[index].image.toString(),
                          ),
                          onBackgroundImageError: (exception, stackTrace) =>
                              const Icon(Icons.person),
                        ),
                        title: Text(teams[index].name ?? ''),
                        trailing: TextButton(
                          onPressed: () {
                            BlocProvider.of<TeamCubit>(context).addPlayerToTeam(
                              teams[index].id.toString(),
                              widget.player.id.toString(),
                            );
                          },
                          child: const Text("Add Player"),
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
