import 'dart:ui' as ui; // Importing dart:ui for TextDirection

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/models/news.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class NewsCard extends StatelessWidget {
  final News? news;
  const NewsCard({super.key, this.news});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Custom date format to match the image
    String formattedDate = DateFormat('d MMMM EEEE yyyy h:mm a')
        .format(DateTime.parse(news?.createdAt ?? ''));

    return Directionality(
      textDirection: ui.TextDirection.rtl, // Use TextDirection from dart:ui
      child: Card(
        elevation: 2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              Hero(
                tag: news?.sId ?? '',
                child: Container(
                  width: screenWidth * 0.2,
                  height:
                      screenWidth * 0.2, // Maintaining a square aspect ratio
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(news?.image ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the right
                  children: [
                    Text(
                      news?.title ?? '',
                      style: const TextStyle(
                        fontFamily: "Pashto",
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: AppColor.blackColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.right, // Align text to the right
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      news?.description ?? '',
                      style: const TextStyle(
                        fontFamily: "Pashto",
                        fontSize: 13,
                        color: AppColor.hintColor,
                      ),
                      textAlign: TextAlign.right, // Align text to the right
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    // Show date and time here
                    const SizedBox(height: 8.0),
                    Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: Text(
                        formattedDate,
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontSize: 12,
                          color: AppColor.grayColor,
                          fontWeight: FontWeight.w500,
                        )),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.right, // Align text to the right
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
