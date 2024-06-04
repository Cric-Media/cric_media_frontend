import 'package:cricket_app/cubits/video/video_cubit.dart';
import 'package:cricket_app/custom_widgets/video_card.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({super.key});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  int indix = 0;

  @override
  void initState() {
    if (VideoCubit.get(context).videos.isEmpty) {
      VideoCubit.get(context).getVideos();
    }
    super.initState();
  }

  void indexes(value) {
    setState(() {
      indix = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      drawer: AppDrawer(screenWidth: screenWidth),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Video Screen'.toUpperCase(),
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 2,
            color: Colors.grey,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          VideoCubit.get(context).getVideos();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Center(
            //   child: Text(
            //     "This feature will be available soon in the app.",
            //     style: TextStyle(
            //       fontSize: 16,
            //       fontWeight: FontWeight.bold,
            //       color: Colors.black,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            BlocConsumer<VideoCubit, VideoState>(
              listener: (context, state) {
                if (state is VideosSuccess) {
                  VideoCubit.get(context).videos = state.res.data;
                } else if (state is VideosMoreSuccess) {
                  VideoCubit.get(context).videos.addAll(state.res.data);
                }
              },
              builder: (context, state) {
                if (state is VideosLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is VideosError) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                      itemCount: VideoCubit.get(context).videos.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var video = VideoCubit.get(context).videos[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 10,
                          ),
                          child: InkWell(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => const VideoDetails()));
                              },
                              child: VideoCard(video: video)),
                        );
                      }),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
