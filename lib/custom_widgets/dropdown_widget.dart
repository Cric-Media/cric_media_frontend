import 'package:cricket_app/constants/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DropdownWidget extends StatefulWidget {
  const DropdownWidget({Key? key, required this.items, this.hint, this.value})
      : super(key: key);

  final List<String> items;
  final String? hint;
  final String? value;

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? value;
  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
      ),
      // width: screenWidth * 0.95,
      height: 65,
      child: DropdownButtonFormField<String>(
        value: value,
        hint: widget.hint == null
            ? null
            : Text(
                widget.hint!,
                style: const TextStyle(color: Colors.white),
              ),
        onChanged: (v) {
          setState(() {
            value = v;
          });
        },
        items: widget.items.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: Text(
                value,
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(bottom: 2),
          filled: true,
          fillColor: AppColor.blueColor,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: const BorderSide(color: AppColor.grayColor, width: 0.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: const BorderSide(color: AppColor.grayColor, width: 0.2),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
