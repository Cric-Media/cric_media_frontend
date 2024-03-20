import 'package:cricket_app/constants/app_color.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? iconImagePath;
  final TextEditingController? controller;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final bool? readOnly;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.iconImagePath,
    this.controller,
    this.isPassword = false,
    this.validator,
    this.prefixIcon,
    this.readOnly,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? obscureText;

  showVisibility() {
    setState(() {
      obscureText = !obscureText!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          cursorHeight: 25,
          readOnly: widget.readOnly ?? false,
          cursorColor: AppColor.blueColor,
          cursorWidth: 2,
          controller: widget.controller,
          obscureText: obscureText ?? widget.isPassword,
          validator: widget.validator,
          decoration: InputDecoration(
            border: InputBorder.none,
            disabledBorder: InputBorder.none,
            suffixIcon: widget.isPassword == true
                ? IconButton(
                    onPressed: showVisibility,
                    icon: Icon(
                      obscureText == true
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  )
                : null,
            prefixIcon: widget.iconImagePath != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExtendedImage.asset(
                      '${widget.iconImagePath}',
                      width: 24,
                      height: 24,
                    ),
                  )
                : widget.prefixIcon,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: AppColor.hintColor.withOpacity(0.8),
              fontSize: screenWidth * 0.040,
            ),
            fillColor: AppColor.textfieldColor,
            filled: true,
            // focusedBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(7),
            //   borderSide:
            //       const BorderSide(color: AppColor.blueColor, width: 0.5),
            // ),
            // errorBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(7),
            //   borderSide:
            //       const BorderSide(color: AppColor.redColor, width: 0.5),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(7),
            //   borderSide:
            //       const BorderSide(color: AppColor.grayColor, width: 0.5),
            // ),
          ),
        ),
        // Show validation error message if validation fails
      ],
    );
  }
}
