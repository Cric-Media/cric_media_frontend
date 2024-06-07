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
                  height: screenWidth * 0.2, // Maintaining a square aspect ratio
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
                  crossAxisAlignment: CrossAxisAlignment.end, // Align text to the right
                  children: [
                    Text(
                      news?.title ?? '',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.right, // Align text to the right
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      news?.description ?? '',
                      style: GoogleFonts.inter(
                        textStyle: const TextStyle(
                          fontSize: 14,
                          color: AppColor.hintColor,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      textAlign: TextAlign.right, // Align text to the right
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    // Show date here
                    const SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end, // Align row to the right
                      children: [
                        Text(
                          DateFormat('dd MMMM yyyy')
                              .format(DateTime.parse(news?.createdAt ?? '')),
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              )),
                          maxLines: 1,
                          textAlign: TextAlign.right, // Align text to the right
                        ),
                        // Show time here
                        const SizedBox(width: 4.0),
                        Text(
                          DateFormat('hh:mm a')
                              .format(DateTime.parse(news?.createdAt ?? '')),
                          style: GoogleFonts.inter(
                              textStyle: const TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              )),
                          maxLines: 1,
                          textAlign: TextAlign.right, // Align text to the right
                        ),
                      ],
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
