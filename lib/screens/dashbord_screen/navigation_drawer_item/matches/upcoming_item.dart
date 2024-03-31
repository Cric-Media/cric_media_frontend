// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/custom_up_coming_matches_card.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';

class UpComingItem extends StatefulWidget {
  const UpComingItem({super.key});

  @override
  State<UpComingItem> createState() => _UpComingItem();
}

class _UpComingItem extends State<UpComingItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('matchDetails')
          .where('matchStatus', isEqualTo: 0)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          MatchCubit.get(context).upcomingMatchDetailsList = snapshot.data!.docs
              .map((doc) => MatchDetails.fromJson(doc.data()))
              .toList();
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      MatchCubit.get(context).upcomingMatchDetailsList.length,
                  itemBuilder: (ctx, index) {
                    var record =
                        MatchCubit.get(context).upcomingMatchDetailsList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: UpCommingMachesCard(),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
