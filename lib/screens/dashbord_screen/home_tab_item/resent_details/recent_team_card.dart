// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentTeamCard extends StatelessWidget {
  const RecentTeamCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              child: Image.asset(AppIcons.player1),
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'M Nabi',
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.w500)),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Row(
                children: [
                  Text(
                    '23',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '33',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '22',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '52',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    '11',
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
        SizedBox(
          height: 10,
        ),
        Text(
          'c Afridi b Hassan ',
          style: GoogleFonts.inter(
              textStyle: TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          )),
        )
      ],
    );
  }
}
