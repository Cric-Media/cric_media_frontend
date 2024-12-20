import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentLiveBatsmanCard extends StatefulWidget {
  final MatchDetails? match;
  const RecentLiveBatsmanCard({super.key, this.match});

  @override
  State<RecentLiveBatsmanCard> createState() => _RecentLiveBatsmanCardState();
}

class _RecentLiveBatsmanCardState extends State<RecentLiveBatsmanCard> {
  PlayerStats? striker, nonStriker;

  @override
  Widget build(BuildContext context) {
    if (widget.match?.playerStats != null) {
      if (widget.match?.striker != null) {
        striker = widget.match?.playerStats?.firstWhere(
          (p) => p.player?.id == widget.match?.striker?.id,
          orElse: () => PlayerStats(
            player: widget.match?.striker,
            runs: 0,
            ballsFaced: 0,
            fours: 0,
            sixes: 0,
            strikeRate: 0,
          ),
        );
      }
      if (widget.match?.nonStriker != null) {
        nonStriker = widget.match?.playerStats?.firstWhere(
          (p) => p.player?.id == widget.match?.nonStriker?.id,
          orElse: () => PlayerStats(
            player: widget.match?.nonStriker,
            runs: 0,
            ballsFaced: 0,
            fours: 0,
            sixes: 0,
            strikeRate: 0,
          ),
        );
      }
    }
    return Column(
      children: [
        if (striker != null)
          Row(
            children: [
              SizedBox(
                // width: 25,
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    widget.match?.striker?.imageUrl ?? '',
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.match?.striker != null
                              ? widget.match?.striker?.name ?? "Striker"
                              : 'Striker',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(AppIcons.bat),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${striker?.runs ?? 0}",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Text(
                          '(${striker?.ballsFaced ?? 0})',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${striker?.fours ?? 0}',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${striker?.sixes ?? 0}',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${striker?.strikeRate?.toStringAsFixed(1) ?? 0}',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        const SizedBox(height: 20),
        if (nonStriker != null)
          Row(
            children: [
              SizedBox(
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    widget.match?.nonStriker?.imageUrl ?? '',
                  ),
                ),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          widget.match?.nonStriker != null
                              ? widget.match?.nonStriker?.name ?? "Non Striker"
                              : 'Non Striker',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 10),
                        const SizedBox(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${nonStriker?.runs ?? 0}",
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Text(
                          '(${nonStriker?.ballsFaced ?? 0})',
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${nonStriker?.fours ?? 0}',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${nonStriker?.sixes ?? 0}',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${nonStriker?.strikeRate?.toStringAsFixed(1) ?? 0}',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
