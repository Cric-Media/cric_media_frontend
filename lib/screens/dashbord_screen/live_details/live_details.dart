import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/match_details_live_card.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_info.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_live.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_point_table.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/scorecard_tab.dart';
import 'package:cricket_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveDetails extends StatefulWidget {
  final MatchDetails? match;
  const LiveDetails({super.key, this.match});

  @override
  State<LiveDetails> createState() => _LiveDetails();
}

class _LiveDetails extends State<LiveDetails> {
  MatchDetails? match;

  int value = 0;
  getVlaue(int x) {
    value = x;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    MatchCubit.get(context).getMatch(widget.match!.sId.toString());
    SocketService.instance.socket.on('match-${widget.match?.sId}', (data) {
      MatchCubit.get(context).getMatch(widget.match!.sId.toString());
      MatchCubit.get(context).getInitialOvers(widget.match!.sId.toString());
    });
  }

  @override
  void dispose() {
    // Remove the listener for the 'match' event when the widget is disposed
    // SocketService.instance.socket.off('match-${widget.match?.sId}');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return DefaultTabController(
      length: 3, // change the number to 4, when adding points table
      child: Scaffold(
        backgroundColor: const Color(0XFFFBFBFB),
        appBar: AppBar(
          title: Text(
            'Live Details '.toUpperCase(),
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                  fontSize: 20,
                  color: AppColor.blackColor,
                  fontWeight: FontWeight.w700),
            ),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<MatchCubit, MatchState>(
          listener: (context, state) {
            if (state is MatchGetSuccess) {
              match = state.res.data;
            } else if (state is MatchGetError) {
              match = MatchDetails();
            }
          },
          builder: (context, state) {
            if (match == null || state is MatchGetLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is MatchGetError) {
              return Center(
                child: Text(state.message),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 5),
                    Hero(
                      tag: match?.sId.toString() ?? '',
                      child: MatchDetailsLiveCard(match: match),
                    ),
                    const SizedBox(height: 5),
                    Card(
                      color: Colors.white,
                      elevation: 2,
                      child: Container(
                          width: screenWidth,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white),
                          child: Row(
                            children: [
                              const SizedBox(width: 25),
                              InkWell(
                                onTap: () {
                                  getVlaue(0);
                                },
                                child: Text(
                                  'Info',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        fontSize: 16,
                                        color: value == 0
                                            ? Colors.black
                                            : Colors.grey,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30),
                              InkWell(
                                  onTap: () {
                                    getVlaue(1);
                                  },
                                  child: Text(
                                    'Live',
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: value == 1
                                                ? Colors.black
                                                : Colors.grey,
                                            fontWeight: FontWeight.w700)),
                                  )),
                              const SizedBox(width: 30),
                              InkWell(
                                  onTap: () {
                                    getVlaue(2);
                                  },
                                  child: Text(
                                    'Scorecard',
                                    style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            fontSize: 16,
                                            color: value == 2
                                                ? Colors.black
                                                : Colors.grey,
                                            fontWeight: FontWeight.w700)),
                                  )),
                              const SizedBox(
                                width: 30,
                              ),
                              // InkWell(
                              //     onTap: () {
                              //       getVlaue(3);
                              //     },
                              //     child: Text(
                              //       'Points Table',
                              //       style: GoogleFonts.inter(
                              //           textStyle: TextStyle(
                              //               fontSize: 16,
                              //               color: value == 3
                              //                   ? Colors.black
                              //                   : Colors.grey,
                              //               fontWeight: FontWeight.w700)),
                              //     )),
                            ],
                          )
                          // child: TabBar(
                          //   tabs: [
                          //     Tab(text: 'Info'),
                          //     Tab(text: 'Live'),
                          //     Tab(text: 'Scorecard'),
                          //     Tab(text: 'Points Table'),
                          //   ],
                          //   indicatorColor: Colors.green,
                          //   labelColor: AppColor.blackColor,
                          //   unselectedLabelColor: AppColor.grayColor,
                          // ),

                          ),
                    ),
                    value == 0
                        ? LiveInfo(match: match)
                        : value == 1
                            ? LiveLive(match: match)
                            : value == 2
                                ? ScorecardTab(
                                    match:
                                        match) /* LiveScoreCard(match: match) */
                                : value == 3
                                    ? const LivePointTable()
                                    : Container(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
