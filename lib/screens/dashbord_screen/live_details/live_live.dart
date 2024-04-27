import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/recent_live_batsman_card.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveLive extends StatefulWidget {
  final MatchDetails? match;
  const LiveLive({super.key, this.match});

  @override
  State<LiveLive> createState() => _LiveLiveState();
}

class _LiveLiveState extends State<LiveLive> {
  @override
  void initState() {
    MatchCubit.get(context).getInitialOvers(widget.match!.sId.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var currentOverNumber = (widget.match!.currentOver!.number ?? 0) + 1;
    final bowlerStatsIndex = widget.match!.bowlerStats!.indexWhere(
      (element) => element.player!.id == widget.match!.openingBowler!.id,
    );

    return Column(children: [
      // Card(
      //   elevation: 2,
      //   color: Colors.white,
      //   child: Container(
      //     width: screenWidth,
      //     height: 75,
      //     decoration: BoxDecoration(
      //         borderRadius: BorderRadius.circular(12), color: Colors.white),
      //     child: Padding(
      //       padding:
      //           const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      //       child: Row(
      //         children: [
      //           Column(
      //             mainAxisAlignment: MainAxisAlignment.start,
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               Text(
      //                 'AFG Loose by 100 runs',
      //                 style: GoogleFonts.inter(
      //                     textStyle: TextStyle(
      //                         color: AppColor.blueColor,
      //                         fontSize: 14,
      //                         fontWeight: FontWeight.w600)),
      //               ),
      //               SizedBox(
      //                 height: 20,
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Text(
      //                     'CRR:4.67',
      //                     style: GoogleFonts.inter(
      //                         textStyle: TextStyle(
      //                             fontSize: 13,
      //                             color: AppColor.hintColor,
      //                             fontWeight: FontWeight.w500)),
      //                   ),
      //                   SizedBox(
      //                     width: 20,
      //                   ),
      //                   Text(
      //                     'RR:5.67',
      //                     style: GoogleFonts.inter(
      //                         textStyle: TextStyle(
      //                             fontSize: 13,
      //                             color: AppColor.hintColor,
      //                             fontWeight: FontWeight.w500)),
      //                   ),
      //                 ],
      //               )
      //             ],
      //           ),
      //           Spacer(),
      //           Padding(
      //             padding: const EdgeInsets.only(right: 10.0),
      //             child: Column(
      //               mainAxisAlignment: MainAxisAlignment.center,
      //               children: [
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       'Target: ',
      //                       style: GoogleFonts.inter(
      //                           textStyle: TextStyle(
      //                               fontSize: 13,
      //                               color: AppColor.hintColor,
      //                               fontWeight: FontWeight.w500)),
      //                     ),
      //                     SizedBox(width: 7),
      //                     Text(
      //                       '200',
      //                       style: GoogleFonts.inter(
      //                           textStyle: TextStyle(
      //                               fontSize: 13,
      //                               color: AppColor.hintColor,
      //                               fontWeight: FontWeight.w500)),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(
      //                   width: 12,
      //                 ),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.start,
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text(
      //                       'Total:',
      //                       style: GoogleFonts.inter(
      //                           textStyle: TextStyle(
      //                               fontSize: 13,
      //                               color: AppColor.hintColor,
      //                               fontWeight: FontWeight.w500)),
      //                     ),
      //                     SizedBox(
      //                       width: 7,
      //                     ),
      //                     Text(
      //                       '100',
      //                       style: GoogleFonts.inter(
      //                           textStyle: TextStyle(
      //                               fontSize: 13,
      //                               color: AppColor.hintColor,
      //                               fontWeight: FontWeight.w500)),
      //                     ),
      //                   ],
      //                 )
      //               ],
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      const SizedBox(height: 5),
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
                        const Expanded(
                          flex: 3,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '4s',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(width: 30),
                              Text(
                                '6s',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                'SR',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
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
                      children: [
                        if (widget.match?.lastWicket?.player != null)
                          Text(
                              "Last Wkt: ${widget.match?.lastWicket?.player?.name} ${widget.match?.lastWicket?.runs}(${widget.match?.lastWicket?.runs})")
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 18.0, right: 20),
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         'P’ship:',
                    //         style: TextStyle(
                    //           fontSize: 12,
                    //           color: Colors.grey,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //       Text(
                    //         ' 90(100)',
                    //         style: TextStyle(
                    //           fontSize: 12,
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //       Spacer(),
                    //       Text(
                    //         'Last Wkt: ',
                    //         style: TextStyle(
                    //           fontSize: 12,
                    //           color: Colors.grey,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //       Text(
                    //         'H Zazai 10 (7)',
                    //         style: TextStyle(
                    //           fontSize: 12,
                    //           color: Colors.black,
                    //           fontWeight: FontWeight.w500,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 8),
      // Card(
      //   elevation: 2,
      //   color: Colors.white,
      //   child: Container(
      //     width: screenWidth,
      //     // height: 100,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //     child: Padding(
      //       padding:
      //           const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
      //       child: Column(
      //         children: [
      //           Row(
      //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //             crossAxisAlignment: CrossAxisAlignment.end,
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.only(left: 5.0),
      //                 child: Text(
      //                   'Bowling',
      //                   style: GoogleFonts.inter(
      //                       textStyle: TextStyle(
      //                     fontSize: 15,
      //                     color: AppColor.blueColor,
      //                     fontWeight: FontWeight.w600,
      //                   )),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(right: 50.0),
      //                 child: Row(
      //                   children: [
      //                     Text(
      //                       'O',
      //                       style: TextStyle(
      //                           fontSize: 15,
      //                           color: Colors.black,
      //                           fontWeight: FontWeight.w600),
      //                     ),
      //                     SizedBox(
      //                       width: 30,
      //                     ),
      //                     Text(
      //                       'M',
      //                       style: TextStyle(
      //                           fontSize: 15,
      //                           color: Colors.black,
      //                           fontWeight: FontWeight.w600),
      //                     ),
      //                     SizedBox(
      //                       width: 30,
      //                     ),
      //                     Text(
      //                       'E',
      //                       style: TextStyle(
      //                           fontSize: 15,
      //                           color: Colors.black,
      //                           fontWeight: FontWeight.w600),
      //                     ),
      //                     SizedBox(
      //                       width: 30,
      //                     ),
      //                     Text(
      //                       'W',
      //                       style: TextStyle(
      //                           fontSize: 15,
      //                           color: Colors.black,
      //                           fontWeight: FontWeight.w600),
      //                     ),
      //                     SizedBox(
      //                       height: 25,
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //             ],
      //           ),
      //           SizedBox(
      //             height: 15,
      //           ),
      //           RecentLiveBollingCard(match: match),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      // SizedBox(
      //   height: 7,
      // ),
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
                    Text(widget.match!.openingBowler!.name ?? "Bowler"),
                    const Spacer(),
                    if (bowlerStatsIndex != -1)
                      Text(
                        "${widget.match!.bowlerStats![bowlerStatsIndex].runsGiven}-${widget.match!.bowlerStats![bowlerStatsIndex].wickets} (${widget.match!.bowlerStats![bowlerStatsIndex].overs}.${widget.match?.team1Batting == true ? widget.match?.team2Balls : widget.match?.team1Balls})",
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
                                                  : e.runsScored.toString(),
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
                                                      : i.runsScored == 6
                                                          ? Colors.pink
                                                          : i.isExtra == true
                                                              ? Colors.brown
                                                              : i.isWicket ==
                                                                      true
                                                                  ? Colors.red
                                                                  : Colors.grey,
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: Text(
                                                  (i.extraType == 'wides')
                                                      ? "WD"
                                                      : (i.isWicket == true)
                                                          ? "W"
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
