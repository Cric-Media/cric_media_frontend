// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, unnecessary_cast

import 'dart:io';

import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/constent/app_images.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/providers/add_new_player_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../custom_widgets/costom_text_field.dart';

class AddNewPlayerScreen extends StatefulWidget {
  const AddNewPlayerScreen({super.key});

  @override
  State<AddNewPlayerScreen> createState() => _AddNewPlayerScreenState();
}

class _AddNewPlayerScreenState extends State<AddNewPlayerScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<AddNewPlayerProvider>(
        builder: (BuildContext context, value, child) {
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
                'Add Players',
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
            child: Form(
              key: _formKey,
              child: Stack(
                children: [
                  if (value.isLoading) // Show indicator if loading
                    Positioned.fill(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  Column(
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
                                border: Border.all(
                                  color: value.pickedImagePath == null
                                      ? Colors.red
                                      : AppColor.blueColor,
                                  width: 2,
                                ),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: value.pickedImagePath != null
                                      ? FileImage(File(value.pickedImagePath))
                                          as ImageProvider<Object>
                                      : AssetImage(
                                              'assets/image/babar_azam.png')
                                          as ImageProvider<Object>,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(right: 5.0, bottom: 5),
                              child: GestureDetector(
                                onTap: () {
                                  value.pickImage();
                                },
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
                          'Player Name',
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
                        controller: value.playerNameController,
                        hintText: 'Enter player name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter player name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Player Location',
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
                        controller: value.playerLocation,
                        hintText: 'Enter player location',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter player location';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Select player type ',
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
                          borderRadius: BorderRadius.circular(7),
                        ),
                        width: screenWidth * 0.95,
                        height: 65,
                        child: DropdownButtonFormField<String>(
                          value: value.selectedBookingFor,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              value.selectedBookingFor = newValue;
                            }
                          },
                          items: ['boller', 'matsman']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
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
                              borderSide: BorderSide(
                                  color: AppColor.grayColor, width: 0.2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: BorderSide(
                                  color: AppColor.grayColor, width: 0.2),
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
                          'Age',
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
                        controller: value.playerAge,
                        hintText: 'Enter player age',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter player age';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Age must be a number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Provide addition infromation',
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
                        controller: value.playerInformation,
                        hintText: 'Enter additional information',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter additional information';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          value.addNewPlayerMethod(context);
                          value.setLoading(true);
                        },
                        child: CustomButton(
                          buttonText: 'Submit',
                          backgroundColor: AppColor.blueColor,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
