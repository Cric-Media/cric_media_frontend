import 'package:cricket_app/models/score_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentTeamCard extends StatelessWidget {
  final Batsmen? batsman;
  const RecentTeamCard({super.key, this.batsman});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (batsman != null)
            Row(
              children: [
                Image.network(
                  batsman!.player!.imageUrl.toString(),
                  height: 40,
                  width: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 8),
                Text(
                  batsman?.player?.name ?? "",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500)),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${batsman?.runs ?? 0}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '${batsman?.ballsFaced ?? 0}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        '${batsman?.fours ?? 0}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        '${batsman?.sixes ?? 0}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        '${batsman?.strikeRate?.toStringAsFixed(2)}',
                        style: const TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Text(
          //   'c Afridi b Hassan ',
          //   style: GoogleFonts.inter(
          //       textStyle: const TextStyle(
          //     fontSize: 14,
          //     color: Colors.black,
          //     fontWeight: FontWeight.w500,
          //   )),
          // )
        ],
      ),
    );
  }
}
