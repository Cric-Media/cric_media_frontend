import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/video/video_cubit.dart';
import 'package:cricket_app/models/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class VideoDetails extends StatefulWidget {
  final Video? video;
  const VideoDetails({super.key, this.video});

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  late VideoPlayerController _controller;
  InterstitialAd? interstitialAd;

  @override
  void initState() {
    super.initState();
    VideoCubit.get(context).viewVideo(widget.video?.sId ?? '');
    createInterstitialAd();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.video?.videoUrl ??
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    )..initialize().then((_) {
        setState(() {});
      });

    Future.delayed(const Duration(seconds: 5), () {
      showInterstitialAd();
    });
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

  @override
  void dispose() {
    showInterstitialAd();
    super.dispose();
    _controller.dispose();
  }

  void _enterFullScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideo(controller: _controller),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFFFBFBFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Video Detail'.toUpperCase(),
          style: GoogleFonts.inter(
            textStyle: const TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: widget.video?.sId ?? '',
                child: SizedBox(
                  width: screenWidth,
                  height: screenHeight * 0.5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _controller.value.isInitialized
                        ? AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          )
                        : const Center(child: CircularProgressIndicator()),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              _controller.value.isInitialized
                  ? Column(
                      children: [
                        VideoProgressIndicator(
                          _controller,
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: AppColor.blueColor,
                            bufferedColor: Colors.grey,
                            backgroundColor: Colors.black,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              iconSize: 40,
                              icon: Icon(
                                _controller.value.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (_controller.value.isPlaying) {
                                    _controller.pause();
                                  } else {
                                    _controller.play();
                                  }
                                });
                              },
                            ),
                            const SizedBox(width: 10),
                            IconButton(
                              icon: const Icon(
                                Icons.fullscreen,
                                color: Colors.black,
                              ),
                              onPressed: _enterFullScreen,
                            )
                          ],
                        ),
                      ],
                    )
                  : Container(),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          DateFormat('dd MMMM yyyy').format(
                              DateTime.parse(widget.video?.createdAt ?? '')),
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          )),
                          maxLines: 1,
                          textAlign: TextAlign.start,
                        ),
                        // show time
                        const SizedBox(width: 5),
                        Text(
                          DateFormat('hh:mm a').format(
                              DateTime.parse(widget.video?.createdAt ?? '')),
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
                    Text(
                      "Viewers ${widget.video?.viewers?.length}",
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
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.video?.title ?? '',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.brown,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  maxLines: 10,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(height: 7),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.video?.description ?? '',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 14,
                      color: AppColor.hintColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FullScreenVideo extends StatelessWidget {
  final VideoPlayerController controller;

  const FullScreenVideo({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: VideoPlayer(controller),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.fullscreen_exit,
          color: Colors.black,
        ),
      ),
    );
  }
}
