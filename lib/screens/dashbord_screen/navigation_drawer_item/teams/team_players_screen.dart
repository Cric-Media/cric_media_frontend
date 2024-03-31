import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TeamPlayersScreen extends StatelessWidget {
  const TeamPlayersScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(
            'Team Players',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 20),
          Expanded(
              child: BlocConsumer<PlayerCubit, PlayerState>(
            listener: (context, state) {
              if (state is PlayerGetInitial) {
                PlayerCubit.get(context).players = state.response.data;
              }
            },
            builder: (context, state) {
              if (state is PlayerGetInitialLoading) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) => const Column(
                    children: [
                      CircleAvatar(radius: 50),
                    ],
                  ),
                  itemCount: 20,
                );
              }
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) => Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: CachedNetworkImageProvider(
                        PlayerCubit.get(context).players[index].imageUrl ?? '',
                      ),
                    ),
                    Text(PlayerCubit.get(context).players[index].name ?? ''),
                  ],
                ),
                itemCount: PlayerCubit.get(context).players.length,
              );
            },
          )),
        ],
      ),
    );
  }
}
