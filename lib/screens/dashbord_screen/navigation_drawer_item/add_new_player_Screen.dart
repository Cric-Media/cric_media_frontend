import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
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
  final String? playerId;
  const AddNewPlayerScreen({super.key, this.playerId});

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
  bool isLoading = false;
  Player? player;

  @override
  void initState() {
    if (widget.playerId != null) {
      BlocProvider.of<PlayerCubit>(context).getPlayer(widget.playerId!);
    } else {}
    super.initState();
  }

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
                    listener: (context, state) {
                      if (state is PlayerAddLoading) {
                        isLoading = true;
                        BlocProvider.of<PlayerCubit>(context)
                            .getPlayersByAdminId();
                      } else if (state is PlayerUpdateLoading) {
                        isLoading = true;
                      } else if (state is PlayerAddSuccess ||
                          state is PlayerUpdateSuccess) {
                        isLoading = false;
                        BlocProvider.of<PlayerCubit>(context)
                            .getPlayersByAdminId();
                        Navigator.pop(context);
                      } else if (state is PlayerAddError) {
                        isLoading = false;
                        showSnack(context, message: state.message);
                      } else if (state is PlayerUpdateError) {
                        isLoading = false;
                        showSnack(context, message: state.message);
                      } else if (state is PlayerGetPlayer) {
                        player = state.response.data;

                        nameController.text = player!.name.toString();
                        locationController.text = player!.location.toString();
                        ageController.text = player!.age.toString();
                        informationController.text =
                            player!.additionalInfo.toString();
                        selectedRole = player!.role;
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
                                      : player != null
                                          ? CachedNetworkImageProvider(
                                              player!.imageUrl.toString(),
                                            )
                                          : AssetImage(AppIcons.profile)
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
                        readOnly: true,
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
                      CustomButton(
                        buttonText: player != null ? 'Update' : 'Submit',
                        backgroundColor: AppColor.blueColor,
                        onTap: () {
                          if (player != null) {
                            update();
                          } else {
                            add();
                          }
                        },
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

  update() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    Player p = Player(
      id: player!.id,
      name: nameController.text.trim(),
      location: locationController.text.trim(),
      role: selectedRole,
      age: ageController.text,
      additionalInfo: informationController.text.trim(),
    );
    BlocProvider.of<PlayerCubit>(context).updatePlayer(p, image);
  }

  add() {
    if (!_formKey.currentState!.validate() && image == null) {
      return;
    }
    Player player = Player(
      name: nameController.text.trim(),
      location: locationController.text.trim(),
      role: selectedRole,
      age: ageController.text,
      additionalInfo: informationController.text.trim(),
    );
    BlocProvider.of<PlayerCubit>(context).addPlayer(
      player: player,
      playerImage: image!,
    );
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
