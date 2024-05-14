import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WinningContainer extends StatelessWidget {
  final String text;
  const WinningContainer({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 25,
      height: 25,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.green,
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            textStyle: TextStyle(fontSize: 18)),
      ),
    );
  }
}
