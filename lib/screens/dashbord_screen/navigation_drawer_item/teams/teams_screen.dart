// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/add_new_team.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  List<Team> teams = [];

  @override
  void initState() {
    BlocProvider.of<TeamCubit>(context).getInitialTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;

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
              ' Team',
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      body: BlocConsumer<TeamCubit, TeamState>(
        listener: (context, state) {
          if (state is TeamGetInitial) {
            teams = state.response.data;
          } else if (state is TeamGetError) {
            print(state.message);
          }
        },
        builder: (context, state) {
          if (state is TeamGetInitialLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            reverse: true,
            shrinkWrap: true,
            itemCount: teams.length,
            padding: EdgeInsets.only(top: 10), // Adjusted for simplicity
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: screenWidth,
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10, left: 10),
                                  height: 75,
                                  width: 75,
                                  decoration: BoxDecoration(),
                                  child: CachedNetworkImage(
                                    imageUrl: teams[index].image ?? "",
                                  ),
                                ),
                                SizedBox(width: 10),
                                Expanded(
                                  flex: 3,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              teams[index].name ?? '',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontSize: 16,
                                                      color:
                                                          AppColor.blackColor,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10.0),
                                            child: Text(
                                              'ID:${teams[index].id?.substring(0, 7)}',
                                              style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      fontSize: 15,
                                                      color:
                                                          AppColor.blackColor,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: Image.asset(
                                              'assets/image/invite.png',
                                              width: 20,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Spacer(),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Image.asset(
                                              AppIcons.edit,
                                              width: 20,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Image.asset(
                                              AppIcons.delete,
                                              width: 20,
                                            ),
                                            SizedBox(
                                              height: 15,
                                            ),
                                            Image.asset(
                                              AppIcons.add,
                                              width: 20,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('ONtAP');
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddNewTeam()));
        },
        backgroundColor: AppColor.blueColor,
        child: Icon(
          Icons.add,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
