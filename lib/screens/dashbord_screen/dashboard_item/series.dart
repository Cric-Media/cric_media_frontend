import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/custom_widgets/tournament_widget.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/home.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/up_coming_series_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2,
                  ),
                  // separatorBuilder: (context, index) => const Divider(),
                  padding: const EdgeInsets.all(8),
                  itemBuilder: (context, index) {
                    var tournament =
                        TournamentCubit.get(context).tournaments[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UpCommingSeriesScreen(),
                          ),
                        );
                      },
                      child: TournamentWidget(
                        tournament: tournament,
                        isAdmin: false,
                      ),
                    );
                  },
                  itemCount: TournamentCubit.get(context).tournaments.length,
                  shrinkWrap: true,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
