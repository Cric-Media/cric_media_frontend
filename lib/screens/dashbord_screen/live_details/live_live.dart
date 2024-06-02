import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/recent_live_batsman_card.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/services/ad_mob_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LiveLive extends StatefulWidget {
  final MatchDetails? match;
  const LiveLive({super.key, this.match});

  @override
  State<LiveLive> createState() => _LiveLiveState();
}

class _LiveLiveState extends State<LiveLive> {
  BannerAd? myBanner;
  @override
  void initState() {
    MatchCubit.get(context).getInitialOvers(widget.match!.sId.toString());
    createBannerAd();
    super.initState();
  }

  createBannerAd() {
    myBanner ??= BannerAd(
      adUnitId: "ca-app-pub-4072951366400579/1184088450",
      size: AdSize.fullBanner,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var currentOverNumber = (widget.match?.currentOver?.number ?? 0) + 1;
    final bowlerStatsIndex = widget.match!.bowlerStats!.indexWhere(
      (element) => element.player?.id == widget.match!.openingBowler!.id,
    );
    final looseScore = widget.match?.winningTeam == widget.match?.team1?.id
        ? (widget.match!.team1Score! - widget.match!.team2Score!)
        : (widget.match!.team2Score! - widget.match!.team1Score!);
    return Column(children: [
      Card(
        elevation: 2,
        child: Container(
          width: screenWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Row(
                children: [
                  if (widget.match!.matchStatus! > 1)
                    Text(
                      "${widget.match?.winningTeam == widget.match?.team1?.id ? widget.match?.team2?.name : widget.match?.team1?.name} loose by $looseScore runs",
                      style: const TextStyle(color: AppColor.blueColor),
                    ),
                  const Spacer(),
                  if (widget.match!.currentInning?.number == 2)
                    Text(
                      "Target: ${widget.match?.team1Batting == true ? widget.match?.team2Score : widget.match?.team1Score}",
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "CRR: ${widget.match?.team1Batting == true ? widget.match?.team1CurrentRunRate : widget.match?.team2CurrentRunRate}",
                  ),
                  const SizedBox(width: 16),
                  Visibility(
                    visible: widget.match?.team2Batting == true,
                    child: Text(
                      "RR: ${widget.match?.team1Batting == true ? widget.match?.team1RequiredRunRate : widget.match?.team2RequiredRunRate}",
                    ),
                  ),
                  const Spacer(),
                ],
              )
            ],
          ),
        ),
      ),
      myBanner == null
          ? Container()
          : Container(
              margin: const EdgeInsets.only(
                // bottom: 4,
                left: 8,
                right: 8,
              ),
              height: 52,
              child: AdWidget(ad: myBanner!),
            ),
      const SizedBox(height: 8),
      Card(
        elevation: 2,
        child: Container(
          width: screenWidth,
          // height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: Column(
              children: [
                Column(
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            'Batsmen',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontSize: 15,
                              color: AppColor.blueColor,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const SizedBox(height: 20, width: 20),
                        const Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "4's",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "6's",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'SR',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    RecentLiveBatsmanCard(match: widget.match),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (widget.match?.partnership != null)
                          Text(
                            "P’ship: ${widget.match?.partnership?.runs}(${widget.match?.partnership?.balls})",
                          ),
                        if (widget.match?.lastWicket?.player != null)
                          Text(
                            "Last Wkt: ${widget.match?.lastWicket?.player?.name} ${widget.match?.lastWicket?.runs}(${widget.match?.lastWicket?.runs})",
                          ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      Card(
        elevation: 2,
        child: Container(
          width: screenWidth,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Over section
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        widget.match?.openingBowler?.imageUrl ?? "",
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(widget.match?.openingBowler?.name ?? "Bowler"),
                    const Spacer(),
                    if (bowlerStatsIndex != -1)
                      Text(
                        "${widget.match?.bowlerStats![bowlerStatsIndex].runsGiven}-${widget.match!.bowlerStats![bowlerStatsIndex].wickets} (${widget.match!.bowlerStats![bowlerStatsIndex].overs}.${widget.match?.team1Batting == true ? widget.match?.team2Balls : widget.match?.team1Balls})",
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Over: $currentOverNumber"),
                    if (widget.match != null)
                      Expanded(
                        child: Wrap(
                          children: widget.match!.currentOver!.balls!
                              .map((e) => Container(
                                    margin: const EdgeInsets.only(left: 8),
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: e.runsScored == 4
                                          ? Colors.lightBlue
                                          : (e.extraType == "byes" ||
                                                  e.extraType == 'leg byes')
                                              ? Colors.orange
                                              : (e.extraType == "no ball")
                                                  ? Colors.deepOrange
                                                  : e.runsScored == 6
                                                      ? Colors.pink
                                                      : e.isExtra == true
                                                          ? Colors.brown
                                                          : e.isWicket == true
                                                              ? Colors.red
                                                              : Colors.grey,
                                      child: (e.extraType == 'wides')
                                          ? const Text(
                                              "WD",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            )
                                          : Text(
                                              e.isWicket == true
                                                  ? "W"
                                                  : (e.extraType == "byes")
                                                      ? "b${e.runsScored}"
                                                      : (e.extraType ==
                                                              "leg byes")
                                                          ? "lb${e.runsScored}"
                                                          : (e.extraType ==
                                                                  "no ball")
                                                              ? "NB"
                                                              : e.runsScored
                                                                  .toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),

      // ! Ball to Ball info:.......:
      BlocConsumer<MatchCubit, MatchState>(
        listener: (context, state) {
          if (state is MatchGetInitialOversSuccess) {
            MatchCubit.get(context).overs = state.res.data;
          } else if (state is MatchGetMoreOversSuccess) {
            MatchCubit.get(context).overPage++;
            MatchCubit.get(context).overs.addAll(state.res.data);
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...MatchCubit.get(context)
                  .overs
                  .map((over) =>
                      // Row(
                      //   children: [
                      //     Text("${e.number} . ${e.balls.length}"),
                      //   ],
                      // ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: over.balls.reversed
                              .map((i) => SizedBox(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "${over.number} . ${over.balls.indexOf(i) + 1}",
                                              ),
                                              const SizedBox(width: 32),
                                              Expanded(
                                                flex: 3,
                                                child: Text(i.ballTo ?? ''),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: 30,
                                                height: 30,
                                                decoration: BoxDecoration(
                                                  color: i.runsScored == 4
                                                      ? Colors.lightBlue
                                                      : (i.extraType ==
                                                                  "byes" ||
                                                              i.extraType ==
                                                                  "leg byes")
                                                          ? Colors.orange
                                                          : (i.extraType ==
                                                                  "no ball")
                                                              ? Colors
                                                                  .deepOrange
                                                              : i.runsScored ==
                                                                      6
                                                                  ? Colors.pink
                                                                  : i.isExtra ==
                                                                          true
                                                                      ? Colors
                                                                          .brown
                                                                      : i.isWicket ==
                                                                              true
                                                                          ? Colors
                                                                              .red
                                                                          : Colors
                                                                              .grey,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Text(
                                                  (i.extraType == 'wides')
                                                      ? "WD"
                                                      : (i.isWicket == true)
                                                          ? "W"
                                                          : (i.extraType ==
                                                                  "byes")
                                                              ? "b"
                                                              : (i.extraType ==
                                                                      "leg byes")
                                                                  ? "lb"
                                                                  : (i.extraType ==
                                                                          "no ball")
                                                                      ? "NB"
                                                                      : "${i.runsScored}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 32),
                                              Expanded(
                                                flex: 3,
                                                child:
                                                    Text(i.description ?? ''),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ))
                  .toList(),
              const SizedBox(height: 16),
              Center(
                child: BlocBuilder<MatchCubit, MatchState>(
                  builder: (context, state) {
                    if (state is MatchGetMoreOversLoading) {
                      return const CircularProgressIndicator();
                    }
                    return ElevatedButton(
                      onPressed: () {
                        MatchCubit.get(context).getMoreOvers(
                          widget.match!.sId.toString(),
                          page: MatchCubit.get(context).overPage,
                          limit: MatchCubit.get(context).overLimit,
                        );
                      },
                      child: const Text("Load more"),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),

      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //   child: Row(
      //     children: [
      //       Text(
      //         'Shaheen Afridi',
      //         style: GoogleFonts.inter(
      //             textStyle: TextStyle(
      //           fontSize: 15,
      //           color: Colors.black,
      //           fontWeight: FontWeight.w600,
      //         )),
      //       ),
      //       Spacer(),
      //       Text(
      //         '34-3(8.4)',
      //         style: GoogleFonts.inter(
      //             textStyle: TextStyle(
      //           fontSize: 15,
      //           color: Colors.black,
      //           fontWeight: FontWeight.w600,
      //         )),
      //       )
      //     ],
      //   ),
      // ),
      // SizedBox(
      //   height: 15,
      // ),
      // Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
      //   child: Row(
      //     children: [
      //       Text(
      //         'Over 45',
      //         style: GoogleFonts.inter(
      //             textStyle: TextStyle(
      //                 fontSize: 14,
      //                 color: Color(0xff7B7B7B),
      //                 fontWeight: FontWeight.w500)),
      //       ),
      //       SizedBox(
      //         width: 15,
      //       ),
      //       Container(
      //         width: 30,
      //         height: 30,
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             shape: BoxShape.circle,
      //             boxShadow: [
      //               BoxShadow(
      //                   color: Colors.grey,
      //                   offset: Offset.zero,
      //                   blurRadius: 1),
      //             ]),
      //         child: Center(
      //           child: Text(
      //             '0',
      //             style: TextStyle(
      //                 fontSize: 15,
      //                 color: Colors.black,
      //                 fontWeight: FontWeight.w500),
      //             textAlign: TextAlign.center,
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         width: 12,
      //       ),
      //       Container(
      //         width: 30,
      //         height: 30,
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             shape: BoxShape.circle,
      //             boxShadow: [
      //               BoxShadow(
      //                   color: Colors.grey,
      //                   offset: Offset.zero,
      //                   blurRadius: 1),
      //             ]),
      //         child: Center(
      //           child: Text(
      //             '1',
      //             style: TextStyle(
      //                 fontSize: 15,
      //                 color: Colors.black,
      //                 fontWeight: FontWeight.w500),
      //             textAlign: TextAlign.center,
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         width: 12,
      //       ),
      //       Container(
      //         width: 30,
      //         height: 30,
      //         decoration: BoxDecoration(
      //             color: Colors.red,
      //             shape: BoxShape.circle,
      //             boxShadow: [
      //               BoxShadow(
      //                   color: Colors.grey,
      //                   offset: Offset.zero,
      //                   blurRadius: 1),
      //             ]),
      //         child: Center(
      //           child: Text(
      //             'w',
      //             style: TextStyle(
      //                 fontSize: 15,
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.w500),
      //             textAlign: TextAlign.center,
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         width: 12,
      //       ),
      //       Container(
      //         width: 30,
      //         height: 30,
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             shape: BoxShape.circle,
      //             boxShadow: [
      //               BoxShadow(
      //                   color: Colors.grey,
      //                   offset: Offset.zero,
      //                   blurRadius: 1),
      //             ]),
      //         child: Center(
      //           child: Text(
      //             '0',
      //             style: TextStyle(
      //                 fontSize: 15,
      //                 color: Colors.black,
      //                 fontWeight: FontWeight.w500),
      //             textAlign: TextAlign.center,
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         width: 12,
      //       ),
      //       Container(
      //         width: 30,
      //         height: 30,
      //         decoration: BoxDecoration(
      //             color: Colors.white,
      //             shape: BoxShape.circle,
      //             boxShadow: [
      //               BoxShadow(
      //                   color: Colors.grey,
      //                   offset: Offset.zero,
      //                   blurRadius: 1),
      //             ]),
      //         child: Center(
      //           child: Text(
      //             '1',
      //             style: TextStyle(
      //                 fontSize: 15,
      //                 color: Colors.black,
      //                 fontWeight: FontWeight.w500),
      //             textAlign: TextAlign.center,
      //           ),
      //         ),
      //       ),
      //       SizedBox(
      //         width: 12,
      //       ),
      //       Container(
      //         width: 30,
      //         height: 30,
      //         decoration: BoxDecoration(
      //             color: Colors.red,
      //             shape: BoxShape.circle,
      //             boxShadow: [
      //               BoxShadow(
      //                   color: Colors.grey,
      //                   offset: Offset.zero,
      //                   blurRadius: 1),
      //             ]),
      //         child: Center(
      //           child: Text(
      //             'w',
      //             style: TextStyle(
      //                 fontSize: 15,
      //                 color: Colors.white,
      //                 fontWeight: FontWeight.w500),
      //             textAlign: TextAlign.center,
      //           ),
      //         ),
      //       ),
      //       Spacer(),
      //       Text(
      //         '2 Runs',
      //         style: GoogleFonts.inter(
      //             textStyle: TextStyle(
      //                 fontSize: 14,
      //                 color: Colors.black,
      //                 fontWeight: FontWeight.w500)),
      //       ),
      //     ],
      //   ),
      // ),
      // SizedBox(
      //   height: 25,
      // ),
      // Container(
      //   height: screenHeight,
      //   child: ListView.builder(
      //       physics: NeverScrollableScrollPhysics(),
      //       itemCount: 9,
      //       itemBuilder: (context, index) {
      //         return RecentLiveMoreInformation();
      //       }),
      // )
    ]);
  }
}
