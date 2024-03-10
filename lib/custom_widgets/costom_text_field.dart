// ignore_for_file: prefer_const_constructors, unnecessary_brace_in_string_interps

import 'package:cricket_app/constent/app_color.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final String? iconImagePath;
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.iconImagePath,
    this.controller,
    this.isPassword = false,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0XFFFBFBFB),
            borderRadius: BorderRadius.circular(7),
          ),
          width: screenWidth * 0.95,
          child: Container(
            color: AppColor.textfieldColor.withOpacity(0.5),
            height: 50,
            child: TextFormField(
              cursorHeight: 25,
              cursorColor: AppColor.blueColor,
              cursorWidth: 2,
              controller: controller,
              obscureText: isPassword,
              validator: validator,
              decoration: InputDecoration(
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                prefixIcon: iconImagePath != null
                    ? Padding(
                        padding: EdgeInsets.all(8.0),
                        child: ExtendedImage.asset(
                          '${iconImagePath}',
                          width: 24,
                          height: 24,
                        ),
                      )
                    : null,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: AppColor.hintColor.withOpacity(0.7),
                  fontSize: screenWidth * 0.040,
                ),
                fillColor: AppColor.textfieldColor.withOpacity(0.5),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: AppColor.grayColor, width: 0.2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7),
                  borderSide: BorderSide(color: AppColor.grayColor, width: 0.2),
                ),
              ),
            ),
          ),
        ),
        // Show validation error message if validation fails
      ],
    );
  }
}
