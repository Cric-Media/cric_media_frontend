import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/constent/app_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VideoDetails extends StatefulWidget {
  const VideoDetails({super.key});

  @override
  State<VideoDetails> createState() => _VideoDetailsState();
}

class _VideoDetailsState extends State<VideoDetails> {
  @override
  Widget build(BuildContext context) {
    final screenWdith = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0XFFFBFBFB),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Video Detail'.toUpperCase(),
          style: GoogleFonts.inter(
              textStyle: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          )),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: screenWdith,
                height: screenHeight * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    AppIcons.newsbaner,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Text(
                '15-2-2024',
                style: GoogleFonts.inter(
                    textStyle: TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                )),
                maxLines: 10,
                textAlign: TextAlign.start,
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Pakistan and India Set to Renew Rivalry',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                    fontSize: 18,
                    color: Colors.brown,
                    fontWeight: FontWeight.w700,
                  )),
                  maxLines: 10,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  'The world of cricket, few matchups generate as much anticipation '
                  '   and excitement as a clash between Pakistan and India. Once again,The world of cricket, few matchups generate as much anticipation and excitement as a clash between Pakistan and India. Once again,The worl d of cricket, few matchups generate as much anticipation and excitement as a clash between Pakistan and India. Once again, these two cricketing giants are set to renew their historic rivalry, and fans across the globe are eagerly awaiting the showdown. these two cricketing giants are set to renew their historic rivalry, and fans across the globe are eagerly awaiting the showdown.'
                  'The worl d of cricket, few matchups generateThe world of cricket, few matchups generate as much anticipation and excitement as a clash between Pakistan and India. Once again, these two cricketing giants are set to renew their historic rivalry, and fans across the globe are eagerly awaiting the showdown. as much anticipation and excitement as a clash between Pakistan and India. Once again, these two cricketing giants are set to renew their historic rivalry, and fans across the globe are eagerly awaiting the showdown.'
                  'The world of cricket, few matchups generate as much anticipation and excitement as a clash between Pakistan and India. Once again, these two cricketing giants are set to renew their historic rivalry, and fans across the globe are eagerly awaiting the showdown.',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: AppColor.hintColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  textAlign: TextAlign.start,
                  // Changed from clip to ellipsis
                  // Optional: Use it if you want to limit the text to a certain number of lines
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
