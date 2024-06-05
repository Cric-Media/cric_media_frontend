import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_resent_widget.dart';
import 'package:cricket_app/screens/dashbord_screen/live_details/live_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompleteItem extends StatefulWidget {
  const CompleteItem({super.key});

  @override
  State<CompleteItem> createState() => _CompleteItem();
}

class _CompleteItem extends State<CompleteItem> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth,
      child: BlocConsumer<MatchCubit, MatchState>(
        listener: (context, state) {
          if (state is MatchGetCompletedSuccess) {
            MatchCubit.get(context).completedMatchDetailsList = state.res.data;
          }
        },
        builder: (context, state) {
          if (state is MatchGetCompletedLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is MatchGetCompletedError) {
            return Center(child: Text(state.message));
          }
          return ListView.builder(
              itemCount:
                  MatchCubit.get(context).completedMatchDetailsList.length,
              itemBuilder: (context, index) {
                var match =
                    MatchCubit.get(context).completedMatchDetailsList[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: InkWell(
                    onTap: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => recentDetails()));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LiveDetails(
                            match: match,
                            fromScorer: false,
                          ),
                        ),
                      );
                    },
                    child: CustomResentWidget(match: match),
                  ),
                );
              });
        },
      ),
    );
  }
}
