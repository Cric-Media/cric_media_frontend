// ignore_for_file: prefer_const_constructors, unnecessary_cast

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/custom_widgets/costom_text_field.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddNewTeam extends StatefulWidget {
  final Team? team;
  const AddNewTeam({super.key, this.team});

  @override
  State<AddNewTeam> createState() => _AddNewTeam();
}

class _AddNewTeam extends State<AddNewTeam> {
  bool isLoading = false;
  var formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  File? image;

  Team? updatedTeam;

  @override
  void initState() {
    updatedTeam = widget.team;
    if (updatedTeam != null) {
      nameController.text = updatedTeam!.name!;
      locationController.text = updatedTeam!.location!;
    }
    super.initState();
  }

  void pickImage() async {
    var img = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() {
        image = File(img.path);
      });
    }
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
            // actions: [
            //   Padding(
            //       padding: const EdgeInsets.only(right: 20.0),
            //       child: Image.asset(
            //         AppIcons.search,
            //         width: 25,
            //         color: Colors.white,
            //       )),
            // ],
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
      body: Form(
        key: formKey,
        child: Padding(
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
                                color: image == null
                                    ? Colors.red
                                    : AppColor.blueColor,
                                width: 2,
                              ),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: updatedTeam != null
                                    ? CachedNetworkImageProvider(
                                        updatedTeam?.image ?? '')
                                    : image != null
                                        ? FileImage(image!)
                                            as ImageProvider<Object>
                                        : AssetImage(AppIcons.team)
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
                                pickImage();
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
                      controller: nameController,
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
                      controller: locationController,
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
                      onTap: () async {
                        if (updatedTeam == null && image == null) {
                          showSnack(context, message: "Please choose an image");
                        } else if (!formKey.currentState!.validate()) {
                          return;
                        } else if (updatedTeam != null) {
                          BlocProvider.of<TeamCubit>(context)
                              .updateTeam(updatedTeam!, image);
                        } else {
                          // Create team
                          final team = Team(
                            name: nameController.text.trim(),
                            location: locationController.text.trim(),
                          );

                          BlocProvider.of<TeamCubit>(context)
                              .addTeam(team: team, teamImage: image!);
                        }
                      },
                    )
                  ],
                ),
                BlocConsumer<TeamCubit, TeamState>(
                  listener: (context, state) {
                    if (state is TeamAddLoading || state is TeamUpdateLoading) {
                      isLoading = true;
                    } else if (state is TeamAddError) {
                      isLoading = false;
                      showSnack(context, message: state.message);
                    } else if (state is TeamAddSuccess ||
                        state is TeamUpdateSuccess) {
                      isLoading = false;
                      BlocProvider.of<TeamCubit>(context).getInitialTeams();
                      Navigator.pop(context);
                    } else if (state is TeamUpdateError) {
                      isLoading = false;
                      showSnack(context, message: state.message);
                    }
                  },
                  builder: (context, state) {
                    if (isLoading) {
                      return const Positioned.fill(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
