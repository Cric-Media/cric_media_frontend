import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchDetailsLiveCard extends StatefulWidget {
  final MatchDetails? match;
  const MatchDetailsLiveCard({super.key, this.match});

  @override
  State<MatchDetailsLiveCard> createState() => _MatchDetailsLiveCardState();
}

class _MatchDetailsLiveCardState extends State<MatchDetailsLiveCard> {
  MatchDetails? match;
  @override
  void initState() {
    SocketService.instance.socket.on('match-${widget.match?.sId}', (data) {
      MatchCubit.get(context).getMatch(widget.match!.sId.toString());
    });
    match = widget.match;
    super.initState();
  }

  @override
  void dispose() {
    // disponse the socket event
    SocketService.instance.socket.off('match-${widget.match?.sId}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<MatchCubit, MatchState>(
      listener: (context, state) {
        if (state is MatchGetSuccess) {
          match = state.res.data;
        }
      },
      builder: (context, state) {
        var winningTeam;
        var winningWickets;
        if (match != null) {
          winningTeam = match?.team1?.id == match?.winningTeam
              ? match?.team1?.name
              : match?.team2?.name;
          winningWickets = match?.team1?.id == match?.winningTeam
              ? (match!.squad1!.length.toInt() - match!.team1Outs!.toInt())
              : (match!.squad2!.length.toInt() - match!.team2Outs!.toInt());
        }
        return Card(
          elevation: 2,
          borderOnForeground: true,
          color: Colors.white,
          child: Container(
            width: screenWidth,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            match != null
                                ? match?.tournamentInfo != null
                                    ? "${match?.tournamentInfo?.tournament?.seriesName} of ${match?.tournamentInfo?.tournament?.seriesLocation}"
                                    : ""
                                : '',
                            style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 14,
                                color: AppColor.blueColor,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            match == null ? 'City' : 'At ${match?.cityOrTown}',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: AppColor.grayColor,
                                    fontWeight: FontWeight.w400)),
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                      const Spacer(),
                      if (match != null) MatchStatusWidget(match: match),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: match == null
                            ? Image.asset("assets/image/pak1.png")
                            : CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  match?.team1?.image ?? '',
                                ),
                              ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        match?.team1?.name ?? '',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w600,
                        )),
                      ),
                      const Spacer(),
                      Text(
                        match == null
                            ? '0/0'
                            : '${match?.team1Score}/${match?.team1Outs}',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor)),
                      ),
                      Text(
                        match == null
                            ? ' (0.0 Overs)'
                            : ' (${match?.team2Overs}.${match?.team2Balls} Overs)',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: AppColor.hintColor)),
                      )
                    ],
                  ),
                  const SizedBox(height: 13),
                  Row(
                    children: [
                      SizedBox(
                        width: 35,
                        height: 35,
                        child: match == null
                            ? Image.asset("assets/image/pak1.png")
                            : CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider(
                                  match?.team2?.image ?? '',
                                ),
                              ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        match?.team2?.name ?? '',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            color: AppColor.blackColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Text(
                        match == null
                            ? '0/0'
                            : '${match?.team2Score}/${match?.team2Outs}',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColor.blackColor)),
                      ),
                      Text(
                        match == null
                            ? ' (0/0 Overs)'
                            : ' (${match?.team1Overs}.${match?.team1Balls} Overs)',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColor.hintColor,
                          ),
                        ),
                      )
                    ],
                  ),
                  if (match != null)
                    Visibility(
                      visible: match!.matchStatus! > 1,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Center(
                            child: Text(
                              '$winningTeam won by $winningWickets wickets',
                              style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: AppColor.blueColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MatchStatusWidget extends StatelessWidget {
  final MatchDetails? match;

  const MatchStatusWidget({Key? key, this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (match!.matchStatus! == 1 && match?.matchStopped?.stop == false) {
      return Container(
        alignment: Alignment.center,
        width: match?.currentInning?.started == false ? 100 : 55,
        height: 30,
        decoration: BoxDecoration(
            color: match?.currentInning?.started == false
                ? Colors.lightBlue
                : Colors.red,
            borderRadius: BorderRadius.circular(7)),
        child: Text(
          match?.currentInning?.started == false ? 'Inning Break' : 'Live',
          style: GoogleFonts.inter(
            textStyle: const TextStyle(fontSize: 13, color: Colors.white),
          ),
        ),
      );
    } else if (match!.matchStatus! == 1 && match?.matchStopped?.stop == true)
      // ignore: curly_braces_in_flow_control_structures
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(
          "Match delayed due to ${match?.matchStopped?.stopReason ?? ''}",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
      );
    else if (match!.matchStatus! > 1 && match?.matchStopped?.stop == false)
      // ignore: curly_braces_in_flow_control_structures
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.green, borderRadius: BorderRadius.circular(7)),
        child: Text(
          "Match Ended",
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 13,
              color: Colors.white,
            ),
          ),
        ),
      );
    else
      // ignore: curly_braces_in_flow_control_structures
      return Container();
  }
}
