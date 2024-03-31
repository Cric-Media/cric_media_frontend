// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/custom_widgets/match_details_live_card.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';

class LiveItem extends StatefulWidget {
  const LiveItem({super.key});

  @override
  State<LiveItem> createState() => _LiveItem();
}

class _LiveItem extends State<LiveItem> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('matchDetails')
          .where('matchStatus', isEqualTo: 1)
          .snapshots(),
      builder: (context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasData) {
          MatchCubit.get(context).liveMatchDetailsList = snapshot.data!.docs
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
                      MatchCubit.get(context).liveMatchDetailsList.length,
                  itemBuilder: (ctx, index) {
                    var record =
                        MatchCubit.get(context).liveMatchDetailsList[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 5),
                      child: MatchDetailsLiveCard(matchDetails: record),
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
