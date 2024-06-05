import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/custom_widgets/costom_text_field.dart';
import 'package:cricket_app/custom_widgets/custom_button.dart';
import 'package:cricket_app/models/tournament.dart';
import 'package:cricket_app/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class AddNewTornament extends StatefulWidget {
  final Tournament? tournament;
  const AddNewTornament({super.key, this.tournament});

  @override
  State<AddNewTornament> createState() => _AddNewTornamentState();
}

class _AddNewTornamentState extends State<AddNewTornament> {
  String selectedBookingFor = 'Hard Bol';

  String bookingFor = '';

  DateTime? selectedDate;
  DateTime? selectedDateend;

  @override
  void initState() {
    TournamentCubit.get(context).clearFields();
    setValues();
    super.initState();
  }

  setValues() {
    if (widget.tournament != null) {
      TournamentCubit.get(context).imageUrl = widget.tournament!.image;
      TournamentCubit.get(context).seriesName.text =
          widget.tournament!.seriesName ?? '';
      TournamentCubit.get(context).seriesLocation.text =
          widget.tournament!.seriesLocation ?? '';
      TournamentCubit.get(context).tournamentType =
          widget.tournament!.tournamentType ?? '';
      TournamentCubit.get(context).numberOfOvers.text =
          widget.tournament!.numberOfOvers.toString();
      TournamentCubit.get(context).numberOfTeams.text =
          widget.tournament!.numberOfTeams.toString();
      TournamentCubit.get(context).startDate = widget.tournament!.startDate;
      TournamentCubit.get(context).endDate = widget.tournament!.endDate;
      selectedDateend = DateTime.parse(widget.tournament!.endDate!);
      selectedDate = DateTime.parse(widget.tournament!.startDate!);
    }
  }

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
        TournamentCubit.get(context).startDate = picked.toIso8601String();
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
        TournamentCubit.get(context).endDate = picked.toIso8601String();
      });
    }
  }

  void _pickImage() async {
    TournamentCubit.get(context).pickImage();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
            title: Text(
              'Add Tournament',
              style: GoogleFonts.inter(
                  textStyle: const TextStyle(
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
              const SizedBox(height: 20),
              Center(
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    BlocBuilder<TournamentCubit, TournamentState>(
                      builder: (context, state) {
                        return Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: AppColor.blueColor, width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: TournamentCubit.get(context).image != null
                                  ? FileImage(
                                          TournamentCubit.get(context).image!)
                                      as ImageProvider<Object>
                                  : TournamentCubit.get(context).imageUrl !=
                                          null
                                      ? CachedNetworkImageProvider(
                                          TournamentCubit.get(context)
                                                  .imageUrl ??
                                              '') as ImageProvider
                                      : AssetImage(AppIcons.profile),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5.0, bottom: 5),
                      child: GestureDetector(
                        onTap: _pickImage,
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
                  'Series Name',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackColor)),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                isPassword: false,
                hintText: 'Enter Series name',
                controller: TournamentCubit.get(context).seriesName,
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
              const SizedBox(
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
              const SizedBox(height: 10),
              CustomTextField(
                isPassword: false,
                hintText: 'Enter Series location',
                controller: TournamentCubit.get(context).seriesLocation,
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
              const SizedBox(height: 15),
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
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  // color: AppColor.textfieldColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(7),
                ),
                width: screenWidth * 0.95,
                height: 65,
                child: DropdownButtonFormField<String>(
                  value: TournamentCubit.get(context).tournamentType,
                  onChanged: (value) {
                    setState(() {
                      selectedBookingFor = value!;
                      TournamentCubit.get(context).tournamentType = value;
                      bookingFor = selectedBookingFor;
                    });
                  },
                  items: ['Hard Ball', 'Tennis Ball ']
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
                            textStyle: const TextStyle(
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
                  'Number of over',
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          fontSize: screenWidth * 0.035,
                          fontWeight: FontWeight.w800,
                          color: AppColor.blackColor)),
                ),
              ),
              const SizedBox(height: 10),
              CustomTextField(
                isPassword: false,
                hintText: 'Enter number of over ',
                controller: TournamentCubit.get(context).numberOfOvers,
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
              const SizedBox(height: 15),
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
              const SizedBox(height: 10),
              CustomTextField(
                isPassword: false,
                hintText: 'Enter number of team',
                controller: TournamentCubit.get(context).numberOfTeams,
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
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
              const SizedBox(height: 10),
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
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () => _selectDateend(context),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
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
              BlocConsumer<TournamentCubit, TournamentState>(
                listener: (context, state) {
                  if (state is TournamentAddSuccess ||
                      state is TournamentUpdateSuccess) {
                    TournamentCubit.get(context).clearFields();
                    TournamentCubit.get(context).getInitialTournaments(
                      isAdmin: true,
                    );
                    Navigator.pop(context);
                  } else if (state is TournamentUpdateError) {
                    AppDialogs.showErrorDialog(
                      context,
                      errorMessage: state.message,
                    );
                  } else if (state is TournamentAddError) {
                    AppDialogs.showErrorDialog(
                      context,
                      errorMessage: state.message,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is TournamentAddLoading ||
                      state is TournamentUpdateLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return CustomButton(
                    buttonText: 'Submit',
                    backgroundColor: AppColor.blueColor,
                    onTap: () {
                      if (widget.tournament != null) {
                        TournamentCubit.get(context).updateTournament(
                          widget.tournament!.sId!,
                        );
                        return;
                      }
                      TournamentCubit.get(context).addTournament();
                    },
                  );
                },
              ),
              const SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
