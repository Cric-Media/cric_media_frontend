// ignore_for_file: prefer_const_constructors, unnecessary_cast

import 'dart:io';

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/custom_widgets/costom_text_field.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/providers/team_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddNewTeam extends StatefulWidget {
  const AddNewTeam({super.key});

  @override
  State<AddNewTeam> createState() => _AddNewTeam();
}

class _AddNewTeam extends State<AddNewTeam> {
  final TextEditingController _textEditingController = TextEditingController();
  // String selectedBookingFor = 'boller';
  // // Flag to enable or disable the TextField
  // String bookingFor = '';
  // ImagePicker _imagePicker = ImagePicker();
  // XFile? _pickedImage;

  // void _pickImage() async {
  //   final pickedImage =
  //       await _imagePicker.pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     _pickedImage = pickedImage;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Consumer<TeamProvider>(
        builder: (BuildContext context, value, Widget? child) {
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
                'Add Team',
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
            child: Stack(
              children: [
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
                                    : AssetImage('assets/image/babar_azam.png')
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
                        'Team Name',
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
                      controller: value.teamNameController,
                      isPassword: false,
                      hintText: 'Enter Team name',
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
                        'Team Location',
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
                      controller: value.teamLocation,
                      isPassword: false,
                      hintText: 'Enter Location name',
                      // iconImagePath: AppIcons.password,
                      //     controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Confirm Password your password';
                        }

                        return null;
                      },
                    ),
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    CustomButton(
                      buttonText: 'Submit',
                      backgroundColor: AppColor.blueColor,
                      onTap: () {
                        value.addNewTeamMethod(context);
                      },
                    )
                  ],
                ),
                if (value.isLoading) // Show indicator if loading
                  Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
