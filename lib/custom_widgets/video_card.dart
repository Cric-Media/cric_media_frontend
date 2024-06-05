import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/models/video.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:video_player/video_player.dart';

class VideoCard extends StatefulWidget {
  final Video? video;
  const VideoCard({super.key, this.video});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        widget.video?.videoUrl ??
            'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
      ),
    )..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWith = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      elevation: 2,
      color: Colors.white,
      child: Container(
        width: screenWith,
        // height: 130,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.video?.sId ?? '',
                  child: Container(
                    height: 100,
                    width: 100,
                    margin: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 4,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Stack(
                      children: [
                        VideoPlayer(_controller),
                        Center(
                          child: IconButton(
                            icon: Icon(
                              _controller.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
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
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.video?.title ?? '',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        )),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.video?.description ?? '',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontSize: 13,
                          color: AppColor.hintColor,
                          fontWeight: FontWeight.w300,
                        )),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow
                            .ellipsis, // Changed from clip to ellipsis
                        maxLines: 2,
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
                          Text(
                            DateFormat('dd MMMM yyyy').format(
                                DateTime.parse(widget.video?.createdAt ?? '')),
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            )),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                          // Show time here
                          const SizedBox(width: 4.0),
                          Text(
                            DateFormat('hh:mm a').format(
                                DateTime.parse(widget.video?.createdAt ?? '')),
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            )),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
