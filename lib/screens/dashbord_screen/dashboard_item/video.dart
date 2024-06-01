import 'package:cricket_app/screens/dashbord_screen/dashboard_item/home.dart';
import 'package:flutter/material.dart';

class Video extends StatefulWidget {
  const Video({super.key});

  @override
  State<Video> createState() => _VideoState();
}

class _VideoState extends State<Video> {
  int indix = 0;

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
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "This feature will be available soon in the app.",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          )
          // ListView.builder(
          //     itemCount: 20,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding:
          //             const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
          //         child: InkWell(
          //             onTap: () {
          //               Navigator.push(
          //                   context,
          //                   MaterialPageRoute(
          //                       builder: (context) => const VideoDetails()));
          //             },
          //             child: const VideoCard()),
          //       );
          //     }),
        ],
      ),
    );
  }
}
