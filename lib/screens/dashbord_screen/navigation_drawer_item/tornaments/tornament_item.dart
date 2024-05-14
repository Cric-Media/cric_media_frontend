import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/add_new_tornament.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          // extra container for custom bottom shadows
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.blueColor,
            automaticallyImplyLeading: true,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Image.asset(
                    AppIcons.search,
                    width: 25,
                    color: Colors.white,
                  )),
            ],
            title: Text(
              'Tornaments',
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewTornament(),
            ),
          );
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
              ListView.separated(
                separatorBuilder: (context, index) => const Divider(),
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  var tournament =
                      TournamentCubit.get(context).tournaments[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        tournament.image ?? '',
                      ),
                    ),
                    title: Text(tournament.seriesName ?? ''),
                    subtitle: Text(
                      DateFormat('dd-MM-yyyy').format(
                        DateTime.parse(tournament.startDate!),
                      ),
                    ),
                  );
                },
                itemCount: TournamentCubit.get(context).tournaments.length,
                shrinkWrap: true,
              )
            ],
          );
        },
      ),
    );
  }
}
