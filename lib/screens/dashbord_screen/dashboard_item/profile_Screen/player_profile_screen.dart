import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/custom_widgets/odi_career_card.dart';
import 'package:cricket_app/custom_widgets/profile_card.dart';
import 'package:cricket_app/custom_widgets/t20_career_card.dart';
import 'package:cricket_app/custom_widgets/test_career_card.dart';
import 'package:cricket_app/models/player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PlayerProfileScreen extends StatefulWidget {
  final String? id;
  const PlayerProfileScreen({super.key, this.id});

  @override
  State<PlayerProfileScreen> createState() => _PlayerProfileScreenState();
}

class _PlayerProfileScreenState extends State<PlayerProfileScreen> {
  Player? player;
  @override
  void initState() {
    super.initState();
    PlayerCubit.get(context).getPlayer(widget.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      appBar: AppBar(
        title: Text(
          'PLAYER PROFILE',
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          )),
        ),
        centerTitle: true,
      ),
      body: BlocConsumer<PlayerCubit, PlayerState>(
        listener: (context, state) {
          if (state is PlayerGetPlayer) {
            player = state.response.data;
          }
        },
        builder: (context, state) {
          if (state is PlayerGetPlayerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is PlayerGetError) {
            return Center(child: Text(state.message));
          }
          return SingleChildScrollView(
            child: Column(children: [
              SizedBox(
                // width: screenWidth,
                width: 200,
                height: 200,
                child: ClipOval(
                  child: player != null
                      ? Hero(
                    tag: player?.id ?? '',
                        child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  player?.imageUrl ?? '',
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                      )
                      : Image.asset(
                          AppIcons.profileimage,
                          fit: BoxFit.contain,
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Container(
                  width: screenWidth,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 1.0,
                          offset: Offset.zero,
                        )
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Personal Information',
                          style: TextStyle(
                              fontSize: 17,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text(
                              'Name: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Text(
                              player?.name ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text(
                              'Born: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Text(
                              player?.age ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.black),
                            )
                          ],
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            const Text(
                              'Role: ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                  color: Colors.black),
                            ),
                            Text(
                              player?.role ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.black),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: LatestPerformanceCard(player: player),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: OdiCareerCard(player: player),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: T20CareerCard(player: player),
              ),
              const SizedBox(
                height: 12,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: TestCareerCard(),
              ),
              const SizedBox(
                height: 50,
              ),
            ]),
          );
        },
      ),
    );
  }
}
