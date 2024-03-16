import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/models/player.dart';
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
    BlocProvider.of<PlayerCubit>(context).getInitialPlayers();
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
            BlocProvider.of<PlayerCubit>(context).getInitialPlayers();
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
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
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

class PlayerTile extends StatelessWidget {
  final Player player;
  const PlayerTile({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade100,
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: CachedNetworkImageProvider(
                    player.imageUrl.toString(),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // name
                        Text(
                          player.name.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        // role
                        Text("Role: ${player.role}"),
                        // id
                        Row(
                          children: [
                            Text("ID: ${player.id!.substring(0, 7)}"),
                            const Spacer(),
                            IconButton(
                              onPressed: () {},
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
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, addNewPlayer,
                              arguments: {"playerId": player.id!});
                        },
                        icon: const Icon(Icons.edit_square),
                      ),
                      IconButton(
                        onPressed: () {
                          AppDialogs.showConfirmationDialog(context,
                              title: "Delete Player?",
                              message:
                                  "Do you really want to delete this player?",
                              onPressed: () {
                            BlocProvider.of<PlayerCubit>(context)
                                .deletePlayer(player.id!);
                          });
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_box),
                      ),
                    ],
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
