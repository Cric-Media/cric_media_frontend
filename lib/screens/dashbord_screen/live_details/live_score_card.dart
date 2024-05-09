import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/custom_widgets/recent_live_bolling_Card.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/resent_details/recent_team_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveScoreCard extends StatelessWidget {
  final MatchDetails? match;
  const LiveScoreCard({super.key, this.match});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset.zero,
                    blurRadius: 2,
                  )
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match != null ? match!.team1!.name! : 'Afghanistan',
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 13),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              'Batsmen',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontSize: 15,
                                color: AppColor.blueColor,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  'R',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'B',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  '4,s',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  '6,s',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'SR',
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
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 820,
                        child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 11,
                            itemBuilder: (context, index) {
                              return const RecentTeamCard();
                            }),
                      ),
                      Row(
                        children: [
                          Text(
                            'Extras: ',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ),
                          const Spacer(),
                          Text(
                            '10 (5 b, 1 lb, 1 wd,1 nb)',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            'Total: ',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ),
                          const Spacer(),
                          Text(
                            ' 230/8 45 Ov(RR4.21)',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            'Target:  ',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black)),
                          ),
                          const Spacer(),
                          Text(
                            ' 300',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey)),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Yet to bat',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Rehmatullah, Mujeeb',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey)),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                  'Fall of wickets: 1-4 (Rohit Sharma, 0.2 ov), 2-193 \n(Shubman Gill, 29.6 ov), 3-196 (Virat Kohli, 31.3 ov),\n 4-256 (KL Rahul, 39.2 ov), 5-276\n (Suryakumar Yadav, 41.3 ov), 6-333 (Shreyas Iyer, 47.3 ov),\n 7-355 (Mohammed Shami, 49.3 ov), 8-357 (Ravindra Jadeja, 49.6 ov)'),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2,
              color: Colors.white,
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              'Bowling',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontSize: 15,
                                color: AppColor.blueColor,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  'O',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'M',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'E',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'W',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'E',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'W',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const RecentLiveBollingCard(),
                      const SizedBox(
                        height: 15,
                      ),
                      const RecentLiveBollingCard(),
                      const SizedBox(
                        height: 15,
                      ),
                      const RecentLiveBollingCard(),
                      const SizedBox(
                        height: 15,
                      ),
                      const RecentLiveBollingCard(),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: screenWidth,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.grey,
                    offset: Offset.zero,
                    blurRadius: 2,
                  )
                ],
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'pakistan',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                            'Batsmen',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontSize: 15,
                              color: AppColor.blueColor,
                              fontWeight: FontWeight.w600,
                            )),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Row(
                            children: [
                              Text(
                                'R',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                'B',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                '4,s',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                '6,s',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Text(
                                'SR',
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
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 820,
                      child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: 11,
                          itemBuilder: (context, index) {
                            return const RecentTeamCard();
                          }),
                    ),
                    Row(
                      children: [
                        Text(
                          'Extras: ',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ),
                        const Spacer(),
                        Text(
                          '10 (5 b, 1 lb, 1 wd,1 nb)',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          'Total: ',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ),
                        const Spacer(),
                        Text(
                          ' 230/8 45 Ov(RR4.21)',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          'Target:  ',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black)),
                        ),
                        const Spacer(),
                        Text(
                          ' 300',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Yet to bat',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black)),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Rehmatullah, Mujeeb',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 7,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                  'Fall of wickets: 1-4 (Rohit Sharma, 0.2 ov), 2-193 \n(Shubman Gill, 29.6 ov), 3-196 (Virat Kohli, 31.3 ov),\n 4-256 (KL Rahul, 39.2 ov), 5-276\n (Suryakumar Yadav, 41.3 ov), 6-333 (Shreyas Iyer, 47.3 ov),\n 7-355 (Mohammed Shami, 49.3 ov), 8-357 (Ravindra Jadeja, 49.6 ov)'),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              elevation: 2,
              color: Colors.white,
              child: Container(
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              'Bowling',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontSize: 15,
                                color: AppColor.blueColor,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(right: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  'O',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'M',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'E',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'W',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'E',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                Text(
                                  'W',
                                  style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 25,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const RecentLiveBollingCard(),
                      const SizedBox(
                        height: 15,
                      ),
                      const RecentLiveBollingCard(),
                      const SizedBox(
                        height: 15,
                      ),
                      const RecentLiveBollingCard(),
                      const SizedBox(
                        height: 15,
                      ),
                      const RecentLiveBollingCard(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
