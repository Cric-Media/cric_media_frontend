import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_contanor_trading_news.dart';
import 'package:cricket_app/custom_widgets/custom_up_coming_matches_card.dart';
import 'package:cricket_app/custom_widgets/match_details_live_card.dart';
import 'package:cricket_app/custom_widgets/onging_series.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/upcoming_match_details.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_details.dart';
import 'package:cricket_app/screens/dashbord_screen/new_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    if (MatchCubit.get(context).liveBannerMatches.isEmpty) {
      MatchCubit.get(context).getBannerMatches(1);
    }
    if (MatchCubit.get(context).upcomingBannerMatches.isEmpty) {
      MatchCubit.get(context).getBannerMatches(0);
    }
    if (TournamentCubit.get(context).fiveTournaments.isEmpty) {
      TournamentCubit.get(context).getFiveTournaments();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SingleChildScrollView(
        child: BlocConsumer<MatchCubit, MatchState>(
          listener: (context, state) {
            if (state is MatchBannerLiveSuccess) {
              MatchCubit.get(context).liveBannerMatches = state.res.data;
            }
            if (state is MatchBannerUpcomingSuccess) {
              MatchCubit.get(context).upcomingBannerMatches = state.res.data;
            }
          },
          builder: (context, state) {
            var upcommingMatches =
                MatchCubit.get(context).upcomingBannerMatches;
            var liveMatches = MatchCubit.get(context).liveBannerMatches;
            return Column(
              children: [
                SizedBox(
                  height: screenWidth * 0.030,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'Matches',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: screenWidth * 0.040,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.w800)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SliderWidget(
                  autoPlayDuration: 400,
                  items: liveMatches.map((match) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LiveDetails(match: match),
                              ),
                            );
                          },
                          child: MatchDetailsLiveCard(match: match),
                        );
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: screenWidth * 0.026),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'Up Coming',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: screenWidth * 0.038,
                              color: AppColor.blackColor,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                SliderWidget(
                  items: upcommingMatches.map((match) {
                    return Builder(
                      builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UpcomingMatchDetails(match: match),
                              ),
                            );
                          },
                          child: UpCommingMachesCard(match: match),
                        );
                      },
                    );
                  }).toList(),
                ),
                // InkWell(
                //     onTap: () {
                //       Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //           builder: (context) => const UpcomingMatchDetails(),
                //         ),
                //       );
                //     },
                //     child: const UpCommingMachesCard()),
                SizedBox(height: screenWidth * 0.030),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'Ongoing Series',
                        style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: screenWidth * 0.038,
                                color: AppColor.blackColor,
                                fontWeight: FontWeight.w800)),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                SizedBox(
                  height: screenWidth * 0.020,
                ),
                BlocConsumer<TournamentCubit, TournamentState>(
                  builder: (context, state) {
                    return Column(children: [
                      ...TournamentCubit.get(context)
                          .fiveTournaments
                          .map(
                            (tournament) => Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Card(
                                elevation: 1,
                                color: Colors.white,
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        tournament.image ?? '',
                                      ),
                                    ),
                                    title: Text(
                                      '${tournament.seriesName}',
                                      style: GoogleFonts.inter(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      '${tournament.seriesLocation}',
                                      style: GoogleFonts.inter(
                                          textStyle: const TextStyle(
                                        fontSize: 12,
                                        color: AppColor.grayColor,
                                        fontWeight: FontWeight.w400,
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList()
                    ]);
                  },
                  listener: (context, state) {
                    if (state is TournamentGetFiveSuccess) {
                      TournamentCubit.get(context).fiveTournaments =
                          state.response.data;
                    }
                  },
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Trending News',
                    style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    )),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewsDetails()));
                    },
                    child: Card(
                      color: Colors.white,
                      elevation: 2,
                      child: Container(
                        width: screenWidth,
                        height: screenHeight * 0.38,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                //     decoration: BoxDecoration(color: Colors.amber),
                                width: screenWidth,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12)),
                                height: 170,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    AppIcons.match_1,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Pakistan and India Set to Renew Rivalry',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                )),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'The world of cricket, few matchups generate as'
                                ' much anticipation and excitement as a clash '
                                '  between Pakistan and India. Once again, these '
                                '   two cricketing giants are set to renew their historic '
                                ' rivalry, and fans across the '
                                '  globe are eagerly awaiting the showdown.',
                                style: GoogleFonts.inter(
                                    textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: AppColor.grayColor,
                                  fontWeight: FontWeight.w300,
                                )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 800,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NewsDetails()));
                              },
                              child: const Custom_Contanor_trading_news()));
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SliderWidget extends StatelessWidget {
  final List<Widget>? items;
  final int? autoPlayDuration;
  const SliderWidget({super.key, this.items, this.autoPlayDuration});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        // height: 200,
        aspectRatio: 2,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(
          milliseconds: autoPlayDuration ?? 800,
        ),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.3,
        scrollDirection: Axis.horizontal,
      ),
      items: items,
    );
  }
}
