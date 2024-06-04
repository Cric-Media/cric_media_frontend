import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/custom_widgets/grid_view_contanor.dart';
import 'package:cricket_app/models/match_details.dart';
import 'package:cricket_app/services/ad_mob_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LiveInfo extends StatefulWidget {
  final MatchDetails? match;
  const LiveInfo({super.key, this.match});

  @override
  State<LiveInfo> createState() => _LiveInfoState();
}

class _LiveInfoState extends State<LiveInfo> {
  NativeAd? nativeAd;

  @override
  void initState() {
    super.initState();
    createNativeAd();
  }

  createNativeAd() {
    nativeAd = NativeAd(
      adUnitId: dotenv.env['NATIVE_AD_UNIT_ID'] ?? '',
      factoryId: 'listTile',
      listener: AdMobService.nativeAdListener,
      request: const AdRequest(),
    )..load();
  }

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
              height: 100,
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
                    const SizedBox(height: 6),
                    Expanded(
                      child: Row(
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
                              widget.match != null
                                  ? "\t\t${widget.match?.matchDateTime}"
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

                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: 'Toss: ',
                                style: GoogleFonts.inter(
                                  textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: widget.match != null
                                        ? widget.match?.tossDetails
                                        : '',
                                    style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                        fontSize: 14,
                                        color: AppColor.hintColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          GridViewContanor(match: widget.match),
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
                            widget.match != null
                                ? "${widget.match?.cityOrTown}"
                                : '',
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
                              widget.match != null
                                  ? "${widget.match?.ground}"
                                  : 'Team',
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
          nativeAd == null
              ? Container()
              : Container(
                  width: screenWidth,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  height: 150,
                  child: AdWidget(ad: nativeAd!),
                ),
        ],
      ),
    );
  }
}
