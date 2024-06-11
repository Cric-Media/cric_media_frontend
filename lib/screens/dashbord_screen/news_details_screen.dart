import 'dart:ui' as ui;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/news/news_cubit.dart';
import 'package:cricket_app/models/news.dart';
import 'package:cricket_app/services/ad_mob_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';

class NewsDetailsScreen extends StatefulWidget {
  final News? news;
  const NewsDetailsScreen({super.key, this.news});

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  BannerAd? myBanner;
  InterstitialAd? interstitialAd;
  NativeAd? nativeAd;

  @override
  void initState() {
    createBannerAd();
    createInterstitialAd();
    createNativeAd();
    NewsCubit.get(context).viewNews(widget.news?.sId ?? '');
    super.initState();
  }

  createBannerAd() {
    myBanner ??= BannerAd(
      adUnitId: dotenv.env['BANNER_AD_UNIT_ID'] ?? '',
      size: AdSize.banner,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: dotenv.env['INTERSTITIAL_AD_UNIT_ID'] ?? '',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) => interstitialAd = ad,
        onAdFailedToLoad: (error) => interstitialAd = null,
      ),
    );
  }

  showInterstitialAd() {
    if (interstitialAd != null) {
      interstitialAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdDismissedFullScreenContent: (ad) {
          ad.dispose();
          createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          ad.dispose();
          createInterstitialAd();
        },
      );
      interstitialAd?.show();
      interstitialAd = null;
    }
  }

  createNativeAd() {
    nativeAd = NativeAd(
      adUnitId: dotenv.env['NATIVE_AD_UNIT_ID'] ?? '',
      listener: AdMobService.nativeAdListener,
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.small,
      ),
    )..load();
  }

  @override
  void dispose() {
    showInterstitialAd();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    // Custom date format to match the image
    String formattedDate = DateFormat('d MMMM EEEE yyyy h:mm a')
        .format(DateTime.parse(widget.news?.createdAt ?? ''));
    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'تفصیلات'.toUpperCase(),
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          )),
        ),
      ),
      body: BlocConsumer<NewsCubit, NewsState>(
        listener: (context, state) {
          if (state is NewsViewSuccessState) {
            NewsCubit.get(context).getNews();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: SingleChildScrollView(
              child: Directionality(
                textDirection:
                    ui.TextDirection.rtl, // Change text direction to RTL
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      tag: widget.news?.sId ?? '',
                      child: SizedBox(
                        width: screenWidth,
                        height: screenHeight * 0.25,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: widget.news?.image ?? '',
                            // fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Directionality(
                                textDirection: ui.TextDirection.ltr,
                                child: Text(
                                  formattedDate,
                                  style: GoogleFonts.inter(
                                      textStyle: const TextStyle(
                                    fontSize: 14,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w500,
                                  )),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign
                                      .right, // Align text to the right
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "ننداره کوونکي ${widget.news?.viewers?.length}",
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            )),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        widget.news?.title ?? '',
                        style: const TextStyle(
                          fontFamily: "Pashto",
                          fontSize: 18,
                          color: Colors.brown,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 10,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    myBanner == null
                        ? const SizedBox.shrink()
                        : Center(
                            child: Container(
                              height: myBanner!.size.height.toDouble(),
                              margin: const EdgeInsets.only(top: 2),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 2),
                              width: myBanner!.size.width.toDouble(),
                              alignment: Alignment.center,
                              child: AdWidget(ad: myBanner!),
                            ),
                          ),
                    const SizedBox(height: 7),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        widget.news?.description ?? '',
                        style: const TextStyle(
                          fontFamily: "Pashto",
                          fontSize: 14,
                          color: AppColor.hintColor,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.start,
                        // Changed from clip to ellipsis
                        // Optional: Use it if you want to limit the text to a certain number of lines
                      ),
                    ),
                    nativeAd == null
                        ? Container()
                        : Container(
                            height: 120,
                            width: screenWidth,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: AdWidget(ad: nativeAd!),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
