import 'dart:io';

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/custom_widgets/costom_text_field.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/models/player.dart';
import 'package:cricket_app/providers/add_new_player_provider.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddNewPlayerScreen extends StatefulWidget {
  const AddNewPlayerScreen({super.key});

  @override
  State<AddNewPlayerScreen> createState() => _AddNewPlayerScreenState();
}

class _AddNewPlayerScreenState extends State<AddNewPlayerScreen> {
  final _formKey = GlobalKey<FormState>();
  // Controllers
  var nameController = TextEditingController();
  var locationController = TextEditingController();
  var ageController = TextEditingController();
  var informationController = TextEditingController();

  // Lists
  List<String> roles = [
    'Batsman',
    'Bowler',
    'All Rounder',
    'Wicket Keeper',
  ];

  // Other Variables
  String? selectedRole;
  File? image;
  PlayerCubit playerCubit = PlayerCubit();
  bool isLoading = false;

  pickImage() async {
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
    return Consumer<AddNewPlayerProvider>(
        builder: (BuildContext context, value, child) {
      return Scaffold(
        backgroundColor: const Color(0XFFFBFBFB),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            // extra container for custom bottom shadows
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: AppColor.blueColor,
              automaticallyImplyLeading: true,
              title: Text(
                'Add Player',
                style: GoogleFonts.inter(
                  textStyle: const TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
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
                  BlocConsumer<PlayerCubit, PlayerState>(
                    bloc: playerCubit,
                    listener: (context, state) {
                      if (state is PlayerAddLoading) {
                        isLoading = true;
                        BlocProvider.of<PlayerCubit>(context)
                            .getInitialPlayers();
                      } else if (state is PlayerAddSuccess) {
                        isLoading = false;
                        Navigator.pop(context);
                      } else if (state is PlayerAddError) {
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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
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
                                  image: image != null
                                      ? FileImage(File(image!.path))
                                          as ImageProvider<Object>
                                      : AssetImage(AppIcons.azam)
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
                                  decoration: const BoxDecoration(
                                    color: AppColor.blueColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Player Name',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w800,
                                color: AppColor.blackColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'Enter player name',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter player name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
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
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: locationController,
                        hintText: 'Enter player location',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter player location';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Select player role ',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.blackColor)),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                        ),
                        width: screenWidth * 0.95,
                        height: 65,
                        child: DropdownButtonFormField<String>(
                          value: selectedRole,
                          hint: const Text('Select player role'),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              selectedRole = newValue;
                              // value.selectedBookingFor = newValue;
                            }
                          },
                          items: roles
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20.0,
                                ),
                                child: Text(
                                  value,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(bottom: 2),
                            filled: true,
                            fillColor: AppColor.textfieldColor.withOpacity(0.4),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
                                  color: AppColor.grayColor, width: 0.2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(7.0),
                              borderSide: const BorderSide(
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
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: ageController,
                        hintText: "Player's date of birth",
                        enabled: true,
                        prefixIcon: IconButton(
                          icon: const Icon(
                            Icons.calendar_today_outlined,
                            color: AppColor.blueColor,
                          ),
                          onPressed: () async {
                            final DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );
                            if (pickedDate != null) {
                              // Store date in DD-MM-YY format
                              ageController.text =
                                  '${pickedDate.day}-${pickedDate.month}-${pickedDate.year}';
                            }
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter player age';
                          }
                          // if (int.tryParse(value) == null) {
                          //   return 'Age must be a number';
                          // }
                          return null;
                        },
                      ),
                      const SizedBox(
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
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: informationController,
                        hintText: 'Enter additional information',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter additional information';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InkWell(
                        onTap: () {
                          // value.addNewPlayerMethod(context);
                          // value.setLoading(true);
                          if (_formKey.currentState!.validate() &&
                              image != null) {
                            Player player = Player(
                              name: nameController.text.trim(),
                              location: locationController.text.trim(),
                              role: selectedRole,
                              age: ageController.text,
                              additionalInfo: informationController.text.trim(),
                            );
                            playerCubit.addPlayer(
                              player: player,
                              playerImage: image!,
                            );
                          }
                        },
                        child: const CustomButton(
                          buttonText: 'Submit',
                          backgroundColor: AppColor.blueColor,
                        ),
                      ),
                      const SizedBox(
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

  @override
  void dispose() {
    nameController.dispose();
    locationController.dispose();
    ageController.dispose();
    informationController.dispose();

    _formKey.currentState?.dispose();
    super.dispose();
  }
}
