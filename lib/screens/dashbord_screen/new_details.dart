import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/models/news.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsDetails extends StatefulWidget {
  final News? news;
  const NewsDetails({super.key, this.news});

  @override
  State<NewsDetails> createState() => _NewsDetailsState();
}

class _NewsDetailsState extends State<NewsDetails> {
  @override
  Widget build(BuildContext context) {
    final screenWdith = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News Detail'.toUpperCase(),
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
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
              SizedBox(
                width: screenWdith,
                height: screenHeight * 0.25,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.news?.image ?? '',
                  ),
                ),
              ),
              Text(
                DateFormat('dd MMMM yyyy')
                    .format(DateTime.parse(widget.news?.createdAt ?? '')),
                style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                )),
                maxLines: 10,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  widget.news?.title ?? '',
                  style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                    fontSize: 18,
                    color: Colors.brown,
                    fontWeight: FontWeight.w700,
                  )),
                  maxLines: 10,
                  textAlign: TextAlign.start,
                ),
              ),
              const SizedBox(
                height: 7,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  widget.news?.description ?? '',
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
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
