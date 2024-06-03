// ignore_for_file: prefer_const_constructors

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/models/news.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsCard extends StatelessWidget {
  final News? news;
  const NewsCard({super.key, this.news});

  @override
  Widget build(BuildContext context) {
    final screenWith = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      elevation: 2,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage(news?.image ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news?.title ?? '',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  )),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                SizedBox(height: 5),
                Text(
                  news?.description ?? '',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                    fontSize: 13,
                    color: AppColor.hintColor,
                    fontWeight: FontWeight.w300,
                  )),
                  textAlign: TextAlign.start,
                  overflow:
                      TextOverflow.ellipsis, // Changed from clip to ellipsis
                  maxLines: 4,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
