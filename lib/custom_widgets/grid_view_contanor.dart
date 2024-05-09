// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/profile_Screen/player_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridViewContanor extends StatelessWidget {
  final MatchDetails? match;
  const GridViewContanor({super.key, this.match});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          Card(
            color: Colors.white,
            elevation: 2,
            child: Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 17.0),
                    child: Text(
                      'Squads',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.blueColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        match != null ? "${match?.team1?.name}" : 'Team 1',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                          ),
                          itemCount: match != null
                              ? match?.squad1?.length
                              : 0, // Example number of items
                          itemBuilder: (BuildContext context, int index) {
                            var player = match?.squad1![index];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerProfileScreen(
                                      id: player?.id,
                                    ),
                                  ),
                                );
                              },
                              child: SquadPlayer(player: player),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Text(
                        match?.team2?.name ?? 'Team 2',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16.0,
                            mainAxisSpacing: 16.0,
                          ),
                          itemCount:
                              match?.squad2?.length, // Example number of items
                          itemBuilder: (BuildContext context, int index) {
                            var player = match?.squad2![index];

                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerProfileScreen(
                                      id: player?.id,
                                    ),
                                  ),
                                );
                              },
                              child: SquadPlayer(player: player),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}

class SquadPlayer extends StatelessWidget {
  final Player? player;
  const SquadPlayer({Key? key, this.player}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: CachedNetworkImage(
            imageUrl: player?.imageUrl ?? '',
            imageBuilder: (context, imageProvider) => Container(
              width: 80,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Expanded(
          child: Column(
            children: [
              Text(
                player?.name ?? '',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                player?.role ?? '',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    fontSize: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
