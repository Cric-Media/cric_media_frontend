import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/custom_widgets/tournament_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TornamentItem extends StatefulWidget {
  const TornamentItem({super.key});

  @override
  State<TornamentItem> createState() => _TornamentItemState();
}

class _TornamentItemState extends State<TornamentItem> {
  @override
  void initState() {
    TournamentCubit.get(context).getInitialTournaments(isAdmin: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: AppColor.blueColor,
        foregroundColor: Colors.white,
        title: Text(
          'Tornaments',
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 19,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, addTournament);
        },
        backgroundColor: AppColor.blueColor,
        child: const Icon(
          Icons.add,
          size: 20,
          color: Colors.white,
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
                      onTap: () => Navigator.pushNamed(
                        context,
                        tournamentDetails,
                        arguments: tournament,
                      ),
                      child: Hero(
                        tag: tournament.sId.toString(),
                        child: TournamentWidget(tournament: tournament),
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
