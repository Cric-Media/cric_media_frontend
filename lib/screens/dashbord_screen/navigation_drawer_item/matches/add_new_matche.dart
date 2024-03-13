// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_build_context_synchronously

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddNewMatche extends StatefulWidget {
  const AddNewMatche({super.key});

  @override
  State<AddNewMatche> createState() => _AddNewMatcheState();
}

class _AddNewMatcheState extends State<AddNewMatche> {
  late DateTime selectedDateTime =
      DateTime.now(); // Initialize with current time
  bool checkBoxValue = false;
  Future<void> _selectDateAndTime(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (pickedTime != null) {
        // Combine the selected date and time
        selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        // Format the selected date and time
        String formattedDateTime =
            DateFormat('EEEE, MMMM d, y - HH:mm').format(selectedDateTime);

        // Print or use the formatted date and time
        print('Selected: $formattedDateTime');

        // Update the UI or perform any other necessary actions
        setState(() {});
      }
    }
  }

  String selectedBookingFor = 'Limited Over ';
  String selectedbollType = ' Hard bol ';
  String selectedPitchType = 'luqman ';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Flag to enable or disable the TextField
    String selectedball = '  ';
    String bookingFor = '';
    String seletedPitch = '';
    // Calculate the starting position for the first container to ensure spacing
    // The formula considers container width (100) and desired space (20) to evenly distribute them
    final double containerWidth = 100;
    final double spaceBetween = 150; // Desired space between the containers
    final double totalWidthNeeded = (containerWidth * 2) + spaceBetween;
    final double startingLeftPosition = (screenWidth - totalWidthNeeded) / 2;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        foregroundColor: Colors.white,
        backgroundColor: AppColor.blueColor,
        title: Text(
          'Add Match',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: screenWidth,
              height: 60,
              color: AppColor.blueColor,
            ),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: screenWidth,
                  height: 100,
                  color: Colors.grey.shade300,
                ),
                Positioned(
                  top: -30,
                  left: startingLeftPosition,
                  child: Column(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppIcons.profile9)),
                          border:
                              Border.all(color: AppColor.blueColor, width: 2),
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Team A Name',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColor.blueColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Squade(0)',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: -15,

                  right: 130,

                  left: startingLeftPosition + containerWidth,
                  // Position it after the first container + space
                  child: Container(
                    alignment: Alignment.center,
                    width: 35,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Text(
                      'Vs',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Positioned(
                  top: -30,
                  right: 10,
                  left: startingLeftPosition +
                      containerWidth +
                      spaceBetween, // Position it after the first container + space
                  child: Column(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(AppIcons.profile9)),
                          border:
                              Border.all(color: AppColor.blueColor, width: 2),
                          shape: BoxShape.circle,
                        ),
                      ),
                      Text(
                        'Team B Name',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 120,
                        height: 30,
                        decoration: BoxDecoration(
                          color: AppColor.blueColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Squade(0)',
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: screenWidth,
              height: screenHeight,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(children: [
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Match Type ',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    width: screenWidth * 0.95,
                    height: 65,
                    child: DropdownButtonFormField<String>(
                      value: selectedBookingFor,
                      onChanged: (value) {
                        setState(() {
                          selectedBookingFor = value!;
                          bookingFor = selectedBookingFor;
                        });
                      },
                      items: [
                        'Limited Over ',
                        'Test Match',
                        'Box Cricket',
                        ' Pair Cricket',
                        ' The Hundred'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                            ),
                            child: Text(
                              value,
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: value == selectedBookingFor
                                      ? Colors.grey
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 2),
                        filled: true,
                        fillColor: AppColor.blueColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide:
                              BorderSide(color: AppColor.grayColor, width: 0.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide:
                              BorderSide(color: AppColor.grayColor, width: 0.2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Ball Type ',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor)),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                    ),
                    width: screenWidth * 0.95,
                    height: 65,
                    child: DropdownButtonFormField<String>(
                      value: selectedbollType,
                      onChanged: (value) {
                        setState(() {
                          selectedbollType = value!;
                          selectedball = selectedbollType;
                        });
                      },
                      items: [
                        ' Hard bol ',
                        'Tennis boll',
                        'other ',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 20.0,
                            ),
                            child: Text(
                              value,
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  fontSize: 18,
                                  color: value == selectedbollType
                                      ? Colors.grey
                                      : Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: 2),
                        filled: true,
                        fillColor: AppColor.blueColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide:
                              BorderSide(color: AppColor.grayColor, width: 0.2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide:
                              BorderSide(color: AppColor.grayColor, width: 0.2),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(7.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Pitch Type ',
                      style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              fontSize: screenWidth * 0.038,
                              fontWeight: FontWeight.w800,
                              color: AppColor.blackColor)),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(7),
                  //   ),
                  //   width: screenWidth * 0.95,
                  //   height: 65,
                  //   child: DropdownButtonFormField<String>(
                  //     value: selectedPitchType,
                  //     onChanged: (value) {
                  //       setState(() {
                  //         selectedPitchType = value!;
                  //         seletedPitch = selectedPitchType;
                  //       });
                  //     },
                  //     items: [' boll', 'good is ']
                  //         .map<DropdownMenuItem<String>>((String value) {
                  //       return DropdownMenuItem<String>(
                  //         value: value,
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(
                  //             left: 20.0,
                  //           ),
                  //           child: Text(
                  //             value,
                  //             style: GoogleFonts.inter(
                  //               textStyle: TextStyle(
                  //                 fontSize: 18,
                  //                 color: value == selectedPitchType
                  //                     ? Colors.grey
                  //                     : Colors.black,
                  //                 fontWeight: FontWeight.w500,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     }).toList(),
                  //     decoration: InputDecoration(
                  //       contentPadding: EdgeInsets.only(bottom: 2),
                  //       filled: true,
                  //       fillColor: AppColor.blueColor,
                  //       enabledBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(7.0),
                  //         borderSide:
                  //             BorderSide(color: AppColor.grayColor, width: 0.2),
                  //       ),
                  //       focusedBorder: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(7.0),
                  //         borderSide:
                  //             BorderSide(color: AppColor.grayColor, width: 0.2),
                  //       ),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(7.0),
                  //         borderSide: BorderSide.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),

                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Number of over ',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColor.hintColor,
                            ),
                          ),
                          Container(
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(0.3)),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: '10',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color:
                                          AppColor.hintColor.withOpacity(0.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none),
                              ))
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Over  per  bowler ',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColor.hintColor,
                            ),
                          ),
                          Container(
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(0.3)),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: '10',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color:
                                          AppColor.hintColor.withOpacity(0.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none),
                              ))
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'City/ Town ',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColor.hintColor,
                            ),
                          ),
                          Container(
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(0.3)),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'City/Town',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color:
                                          AppColor.hintColor.withOpacity(0.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none),
                              ))
                        ],
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ground ',
                            style: TextStyle(
                              fontSize: 15,
                              color: AppColor.hintColor,
                            ),
                          ),
                          Container(
                              width: 180,
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.grey.withOpacity(0.3)),
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Ground',
                                    hintStyle: TextStyle(
                                      fontSize: 20,
                                      color:
                                          AppColor.hintColor.withOpacity(0.5),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    border: InputBorder.none),
                              ))
                        ],
                      )
                    ],
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Match Date and Time',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      _selectDateAndTime(context);
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          selectedDateTime == null
                              ? 'Select time'
                              : 'Selected: ${selectedDateTime.toString()}',
                          style: TextStyle(fontSize: 15, color: Colors.black),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 5,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      ' who win the toss',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.hintColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // or MainAxisAlignment.spaceBetween
                      children: [
                        Checkbox(
                          value: checkBoxValue,
                          onChanged: (value) {
                            setState(() {
                              checkBoxValue = value!;
                            });
                          },
                        ),
                        Text(
                          'Team A Toss',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // or MainAxisAlignment.spaceBetween
                      children: [
                        Checkbox(
                          value: checkBoxValue,
                          onChanged: (value) {
                            setState(() {
                              checkBoxValue = value!;
                            });
                          },
                        ),
                        Text(
                          'Team B Toss',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Toss Details',
                      style: TextStyle(
                        fontSize: 16,
                        color: AppColor.hintColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    height: 30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // or MainAxisAlignment.spaceBetween
                      children: [
                        Checkbox(
                          value: checkBoxValue,
                          onChanged: (value) {
                            setState(() {
                              checkBoxValue = value!;
                            });
                          },
                        ),
                        Text(
                          'Team A Bolling',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 35,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment
                          .start, // or MainAxisAlignment.spaceBetween
                      children: [
                        Checkbox(
                          value: checkBoxValue,
                          onChanged: (value) {
                            setState(() {
                              checkBoxValue = value!;
                            });
                          },
                        ),
                        Text(
                          'Team B Batting',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
