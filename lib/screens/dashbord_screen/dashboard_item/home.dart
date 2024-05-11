import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/constants/global.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/models/admin.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/home_tab.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/live_tab.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/recent_tab.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/upcomingTab.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/match_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/profile_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/tornament_item.dart';
import 'package:cricket_app/utils/app_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int indix = 0;
  Admin? user;

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

    user = BlocProvider.of<AuthCubit>(context).admin;
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        user = BlocProvider.of<AuthCubit>(context).admin;
      },
      builder: (context, state) {
        return DefaultTabController(
            length: 4,
            child: Scaffold(
              backgroundColor: const Color(0XFFFBFBFB),
              appBar: AppBar(
                bottom: const TabBar(
                    dividerHeight: 3,
                    isScrollable: false,
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
                    indicatorColor: AppColor.blueColor),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Image.asset(
                      AppIcons.search,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ],
                title: Text(
                  'Cric Media'.toUpperCase(),
                  style: GoogleFonts.inter(
                    textStyle: const TextStyle(
                      fontSize: 20,
                      color: AppColor.blackColor,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              body: const TabBarView(
                children: [
                  HomeTab(),
                  LiveTab(),
                  UpComingTab(),
                  RecentTab(),
                ],
              ),
              drawer: Drawer(
                  backgroundColor: Colors.white,
                  shadowColor: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      DrawerHeader(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              AppIcons.logo,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment
                              .bottomLeft, // Position text at the bottom left
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .end, // Use minimum space needed by the children
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.name ?? "",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: AppColor.blueColor,
                                  ),
                                ),
                                Text(
                                  user?.email ?? "",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              indexes(0);
                              user == null
                                  ? signinConfirmation()
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const ProfileItem()));
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
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              indexes(1);
                              user == null
                                  ? signinConfirmation()
                                  : Navigator.pushNamed(context, playerItem);
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
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              indexes(2);
                              user == null
                                  ? signinConfirmation()
                                  : Navigator.pushNamed(
                                      context,
                                      teams,
                                    );
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
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              indexes(3);
                              user == null
                                  ? signinConfirmation()
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MatchItem()));
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
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          InkWell(
                            onTap: () {
                              indexes(4);
                              user == null
                                  ? signinConfirmation()
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const TornamentItem()));
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
                                          textStyle: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500)),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          if (user != null)
                            InkWell(
                              onTap: () {
                                indexes(5);
                                user == null
                                    ? signinConfirmation()
                                    : Navigator.pushReplacementNamed(
                                        context,
                                        dashboard,
                                      );
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
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500)),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ]),
                  )),
            ));
      },
    );
  }

  signinConfirmation() {
    AppDialogs.showConfirmationDialog(context,
        title: "Sign in", message: "Do you want to sign in?", onPressed: () {
      Navigator.pushNamed(context, signin);
    });
  }
}
