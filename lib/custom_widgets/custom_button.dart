import 'package:cricket_app/constants/app_color.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback? onTap;
  final double widthFactor;
  final Color backgroundColor; // Parameter for background color
  final TextStyle? textStyle; // Parameter for text style

  const CustomButton({
    Key? key,
    required this.buttonText,
    this.onTap,
    this.widthFactor = 0.9,
    this.backgroundColor = AppColor.blueColor, // Default background color
    this.textStyle = const TextStyle(
      // Default text style
      color: Colors.white,
      fontSize: 18,
      // Specify a default size, will be overridden if textStyle is provided
      fontWeight: FontWeight.bold,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjusted TextStyle to use the entire textStyle parameter
    TextStyle adjustedTextStyle = textStyle!.copyWith(
      fontSize: screenWidth * 0.035, // Adjust fontSize based on screen width
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(7),
      child: Container(
        width: screenWidth * widthFactor,
        height: 53,
        decoration: BoxDecoration(
          color: backgroundColor, // Use the backgroundColor parameter
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: adjustedTextStyle, // Use the adjustedTextStyle
          ),
        ),
      ),
    );
  }
}
