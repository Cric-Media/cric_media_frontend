import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Info extends StatelessWidget {
  final MatchDetails? match;
  const Info({super.key, this.match});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      // Used to make the entire screen scrollable
      child: Column(
        children: [
          const SizedBox(height: 7),
          Card(
            color: Colors.white,
            elevation: 2,
            child: Container(
              width: screenWidth,
              height: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   'Afghanistan tour of Pakistan',
                    //   style: GoogleFonts.inter(
                    //       textStyle: TextStyle(
                    //           fontSize: 15,
                    //           color: AppColor.blueColor,
                    //           fontWeight: FontWeight.w700)),
                    // ),
                    // const SizedBox(height: 5),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Date & Time :',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Expanded(
                            child: Text(
                              match != null
                                  ? "\t\t${match?.matchDateTime}"
                                  : '',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontSize: 14,
                                color: AppColor.hintColor,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 5),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'Match No :   ',
                    //       style: GoogleFonts.inter(
                    //           textStyle: TextStyle(
                    //               fontSize: 14,
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.w600)),
                    //     ),
                    //     Text(
                    //       '    1st Odi',
                    //       style: GoogleFonts.inter(
                    //           textStyle: TextStyle(
                    //         fontSize: 14,
                    //         color: AppColor.hintColor,
                    //         fontWeight: FontWeight.w600,
                    //       )),
                    //     )
                    //   ],
                    // ),
                    // Expanded(
                    //   child: Row(
                    //     children: [
                    //       Text(
                    //         'Toss :\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t',
                    //         style: GoogleFonts.inter(
                    //             textStyle: const TextStyle(
                    //                 fontSize: 14,
                    //                 color: Colors.black,
                    //                 fontWeight: FontWeight.w600)),
                    //       ),
                    //       Expanded(
                    //         child: Text(
                    //           match != null
                    //               ? match?.tossDetails ?? ""
                    //               : '',
                    //           style: GoogleFonts.inter(
                    //               textStyle: const TextStyle(
                    //             fontSize: 14,
                    //             color: AppColor.hintColor,
                    //             fontWeight: FontWeight.w600,
                    //           )),
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
            ),
          ),
          // GridViewContanor(match: match),
          Card(
            color: Colors.white,
            elevation: 2,
            child: Container(
              width: screenWidth,
              height: 130,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Venue',
                      style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                              fontSize: 16,
                              color: AppColor.blueColor,
                              fontWeight: FontWeight.w700)),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'City / Town:\t\t\t',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Text(
                            match != null ? "${match?.cityOrTown}" : '',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontSize: 14,
                              color: AppColor.hintColor,
                              fontWeight: FontWeight.w600,
                            )),
                          )
                        ],
                      ),
                    ),
                    // SizedBox(height: 12),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            'Ground:\t\t\t',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)),
                          ),
                          Expanded(
                            child: Text(
                              match != null ? "${match?.ground}" : '',
                              style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                fontSize: 14,
                                color: AppColor.hintColor,
                                fontWeight: FontWeight.w600,
                              )),
                            ),
                          )
                        ],
                      ),
                    ),
                    // SizedBox(
                    //   height: 12,
                    // ),
                    // Row(
                    //   children: [
                    //     Text(
                    //       'Province:\t\t\t',
                    //       style: GoogleFonts.inter(
                    //           textStyle: TextStyle(
                    //               fontSize: 15,
                    //               color: Colors.black,
                    //               fontWeight: FontWeight.w600)),
                    //     ),
                    //     Text(
                    //       'SIndh',
                    //       style: GoogleFonts.inter(
                    //           textStyle: TextStyle(
                    //         fontSize: 14,
                    //         color: AppColor.hintColor,
                    //         fontWeight: FontWeight.w600,
                    //       )),
                    //     )
                    //   ],
                    // )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
