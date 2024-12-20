import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Custom_Contanor_trading_news extends StatelessWidget {
  const Custom_Contanor_trading_news({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWith = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Card(
      elevation: 2,
      color: Colors.white,
      child: Container(
        width: screenWith,
        height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 130,
                  width: 140,
                  decoration: const BoxDecoration(),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12)),
                    child: Image.asset(
                      AppIcons.azam,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'England Team create history ',
                        style: GoogleFonts.inter(
                            // ignore: prefer_const_constructors
                            textStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        )),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        'It is a long established  fact that \n  goddsf ddf '
                        'a reader will be \n distracted  the readable It is a\n long established  fact that \n  goddsf ddf',
                        style: GoogleFonts.inter(
                            textStyle: const TextStyle(
                          fontSize: 13,
                          color: AppColor.hintColor,
                          fontWeight: FontWeight.w300,
                        )),
                        textAlign: TextAlign.start,
                        overflow: TextOverflow
                            .ellipsis, // Changed from clip to ellipsis
                        maxLines: 4,
                      )
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
