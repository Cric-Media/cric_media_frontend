import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/custom_widgets/placeholders/series_shimmer.dart';
import 'package:cricket_app/models/tournament.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Series extends StatefulWidget {
  const Series({super.key});

  @override
  State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
  @override
  void initState() {
    if (TournamentCubit.get(context).tournaments.isEmpty) {
      TournamentCubit.get(context).getInitialTournaments(isAdmin: false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      drawer: AppDrawer(screenWidth: screenWidth),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Series'.toUpperCase(),
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 17,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: BlocConsumer<TournamentCubit, TournamentState>(
        listener: (context, state) {
          if (state is TournamentGetInitialSuccess) {
            TournamentCubit.get(context).tournaments = state.response.data;
          }
        },
        builder: (context, state) {
          if (state is TournamentGetInitialLoading) {
            return ListView.builder(
              itemBuilder: (context, index) {
                // shimmer
                return const SeriesShimmer();
              },
              itemCount: 10,
            );
          } else if (state is TournamentGetInitialError) {
            return Center(
              child: Text(state.message),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              TournamentCubit.get(context)
                  .getInitialTournaments(isAdmin: false);
            },
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 1,
                    //   crossAxisSpacing: 10,
                    //   mainAxisSpacing: 10,
                    //   childAspectRatio: 2,
                    // ),
                    // separatorBuilder: (context, index) => const Divider(),
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      var tournament =
                          TournamentCubit.get(context).tournaments[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            seriesDetails,
                            arguments: {'id': tournament.sId},
                          );
                        },
                        child: SeriesWidget(tournament: tournament),
                      );
                    },
                    itemCount: TournamentCubit.get(context).tournaments.length,
                    shrinkWrap: true,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class SeriesWidget extends StatelessWidget {
  final Tournament tournament;
  const SeriesWidget({Key? key, required this.tournament}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: CachedNetworkImageProvider(
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
          trailing: tournament.winner != null
              ? Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Winner of tournament',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: AppColor.grayColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          tournament.winner?.name ?? '',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: AppColor.grayColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              : Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Starts on',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: AppColor.grayColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat('dd MMM, yyyy')
                              .format(DateTime.parse(tournament.startDate!)),
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: AppColor.grayColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Ends on',
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: AppColor.grayColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          DateFormat('dd MMM, yyyy')
                              .format(DateTime.parse(tournament.endDate!)),
                          style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                              fontSize: 12,
                              color: AppColor.grayColor,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
