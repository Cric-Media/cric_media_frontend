// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/constent/app_images.dart';
import 'package:cricket_app/custom_widgets/costom_text_field.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class AddNewTornament extends StatefulWidget {
  const AddNewTornament({super.key});

  @override
  State<AddNewTornament> createState() => _AddNewTornamentState();
}

class _AddNewTornamentState extends State<AddNewTornament> {
  final TextEditingController _textEditingController = TextEditingController();
  String selectedBookingFor = 'Hard Bol';

  String bookingFor = '';
  ImagePicker _imagePicker = ImagePicker();
  XFile? _pickedImage;
  DateTime? selectedDate;
  DateTime? selectedDateend;
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      // Update the selected date
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectDateend(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      // Update the selected date
      setState(() {
        selectedDateend = picked;
      });
    }
  }

  void _pickImage() async {
    final pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _pickedImage = pickedImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0XFFFBFBFB),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          // extra container for custom bottom shadows
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.blueColor,
            automaticallyImplyLeading: true,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Image.asset(
                    AppIcons.search,
                    width: 25,
                    color: Colors.white,
                  )),
            ],
            title: Text(
              'Add Tornament',
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColor.blueColor, width: 2),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: _pickedImage != null
                              ? FileImage(File(_pickedImage!.path))
                                  as ImageProvider<
                                      Object> // Cast to ImageProvider<Object>
                              : AssetImage(AppIcons
                                  .azam), // Fallback to a default asset image
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0, bottom: 5),
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            color: AppColor.blueColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Series Name',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackColor)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                isPassword: false,
                hintText: 'Enter Series name',
                // iconImagePath: AppIcons.password,
                //     controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm Password your password';
                  }
                  // Add more validation as needed
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Series Location',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackColor)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                isPassword: false,
                hintText: 'Enter Series location',
                // iconImagePath: AppIcons.password,
                //     controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm Password your password';
                  }
                  // Add more validation as needed
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Select tornament type ',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackColor)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  // color: AppColor.textfieldColor.withOpacity(0.5),
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
                  items: ['Hard Bol', 'Tennis Bol ', 'other']
                      .map<DropdownMenuItem<String>>((String value) {
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
                              color: Colors.grey,
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
                    fillColor: AppColor.textfieldColor.withOpacity(0.4),
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
                  'Number of over',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackColor)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                isPassword: false,
                hintText: 'Enter number of over ',
                // iconImagePath: AppIcons.password,
                //     controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm Password your password';
                  }
                  // Add more validation as needed
                  return null;
                },
              ),
              SizedBox(
                height: 15,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Number of team',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackColor)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                isPassword: false,
                hintText: 'Enter number of team',
                // iconImagePath: AppIcons.password,
                //     controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Confirm Password your password';
                  }
                  // Add more validation as needed
                  return null;
                },
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Tornament start date',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackColor)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        selectedDate != null
                            ? DateFormat('EEEE, MMMM dd, yyyy')
                                .format(selectedDate!)
                            : 'Select Date',
                        style: TextStyle(
                          fontSize: 17,
                          color: selectedDate != null
                              ? Colors.black // Color for selected date
                              : Colors.grey.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Tornament End date',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w800,
                          color: Colors.black // Color for selected date

                          )),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () => _selectDateend(context),
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                        size: 20,
                      ),
                      SizedBox(width: 10),
                      Text(
                        selectedDateend != null
                            ? DateFormat('EEEE, MMMM dd, yyyy')
                                .format(selectedDateend!)
                            : 'Select Date',
                        style: TextStyle(
                          fontSize: 17,
                          color: selectedDateend != null
                              ? Colors.black // Color for selected date
                              : Colors.grey.withOpacity(0.8),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CustomButton(
                buttonText: 'Submit',
                backgroundColor: AppColor.blueColor,
                onTap: () {},
              ),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
