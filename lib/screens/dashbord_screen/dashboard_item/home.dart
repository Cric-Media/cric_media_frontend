// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unused_import, avoid_unnecessary_containers, unnecessary_string_interpolations, use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/models/user.dart';
import 'package:cricket_app/screens/auth_screen/sigin_screen/signIn.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/home_tab.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/live_tab.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/recent_tab.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/upcomingTab.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/match_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/player_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/profile_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/teamsitem.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/tornament_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indix = 0;
  User user = User();

  @override
  void initState() {
    super.initState();
  }

  void indexes(value) {
    setState(() {
      indix = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHieght = MediaQuery.of(context).size.height;

    user = BlocProvider.of<AuthCubit>(context).user;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        user = BlocProvider.of<AuthCubit>(context).user;
      },
      builder: (context, state) {
        return Container(
            child: DefaultTabController(
                length: 4,
                child: Scaffold(
                  backgroundColor: Color(0XFFFBFBFB),
                  appBar: AppBar(
                    bottom: TabBar(
                      dividerHeight: 3,
                      dividerColor: Colors.grey,
                      labelColor: Colors.black,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.w800,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      tabs: [
                        Tab(text: 'Home'),
                        Tab(text: 'Live'),
                        Tab(text: 'Upcoming'),
                        Tab(text: 'Recent'),
                      ],
                      indicatorColor: AppColor
                          .blueColor, // Set the color of the selected tab indicator
                    ),
                    centerTitle: true,
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Image.asset(
                          '${AppIcons.search}',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                    title: Text(
                      'Cric Media'.toUpperCase(),
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: AppColor.blackColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [
                      HomeTab(),
                      LiveTab(),
                      UpComingTab(),
                      RecentTab(),
                    ],
                  ),
                  drawer: Container(
                    child: Drawer(
                        backgroundColor: Colors.white,
                        shadowColor: Colors.white,
                        child: SingleChildScrollView(
                          child: Column(children: [
                            DrawerHeader(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      AssetImage('assets/image/drawericon.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment
                                    .bottomLeft, // Position text at the bottom left
                                child: Container(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment
                                          .end, // Use minimum space needed by the children
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          user.name ?? "",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        Text(
                                          user.email ?? "",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    indexes(0);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfileItem()));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                        color: indix == 0
                                            ? Colors.grey.withOpacity(0.5)
                                            : Colors.transparent),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: ListTile(
                                          leading: Image.asset(
                                            AppIcons.profile3,
                                            width: 25,
                                          ),
                                          title: Text(
                                            'Profile',
                                            style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    indexes(1);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                PlayerItem()));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                        color: indix == 1
                                            ? Colors.grey.withOpacity(0.5)
                                            : Colors.transparent),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: ListTile(
                                          leading: Image.asset(
                                            AppIcons.player5,
                                            width: 25,
                                          ),
                                          title: Text(
                                            'Add player',
                                            style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    indexes(2);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => teamItem()));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                        color: indix == 2
                                            ? Colors.grey.withOpacity(0.5)
                                            : Colors.transparent),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: ListTile(
                                          leading: Image.asset(
                                            AppIcons.team,
                                            width: 25,
                                          ),
                                          title: Text(
                                            'Add Team',
                                            style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    indexes(3);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => MatchItem()));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                        color: indix == 3
                                            ? Colors.grey.withOpacity(0.5)
                                            : Colors.transparent),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: ListTile(
                                          leading: Image.asset(
                                            AppIcons.startmatch,
                                            width: 25,
                                          ),
                                          title: Text(
                                            'Start Match',
                                            style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    indexes(4);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TornamentItem()));
                                  },
                                  child: Container(
                                    height: 50,
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                        color: indix == 4
                                            ? Colors.grey.withOpacity(0.5)
                                            : Colors.transparent),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: ListTile(
                                          leading: Image.asset(
                                            AppIcons.tornament,
                                            width: 25,
                                          ),
                                          title: Text(
                                            'Add Tournaments',
                                            style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    indexes(5);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SigninScreen()));
                                    Global().removeUserId();
                                    Global().deleteIds();
                                    Global().logoutUser();
                                  },
                                  child: Container(
                                    height: 50,
                                    width: screenWidth,
                                    decoration: BoxDecoration(
                                        color: indix == 5
                                            ? Colors.grey.withOpacity(0.5)
                                            : Colors.transparent),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: ListTile(
                                          leading: Image.asset(
                                            AppIcons.logout,
                                            width: 22,
                                          ),
                                          title: Text(
                                            'Log out',
                                            style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                          ),
                                        ))
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          ]),
                        )),
                  ),
                )));
      },
    );
  }
}
