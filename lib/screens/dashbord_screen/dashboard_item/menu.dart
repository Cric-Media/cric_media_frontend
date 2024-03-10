// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/constent/app_images.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/match_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/player_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/profile_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/teamsitem.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/tornament_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int indix = 0;

  void indexes(value) {
    setState(() {
      indix = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0XFFFBFBFB),
      drawer: Drawer(
          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          child: Column(children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image/drawericon.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment:
                    Alignment.bottomLeft, // Position text at the bottom left
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment
                        .end, // Use minimum space needed by the children
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'luqman ali',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'email@example.com',
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
            Column(
              children: [
                InkWell(
                  onTap: () {
                    indexes(0);
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ProfileItem()));
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
                                    fontWeight: FontWeight.w500)),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PlayerItem()));
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
                                    fontWeight: FontWeight.w500)),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => teamItem()));
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
                                    fontWeight: FontWeight.w500)),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MatchItem()));
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
                                    fontWeight: FontWeight.w500)),
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
                            builder: (context) => TornamentItem()));
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
                                    fontWeight: FontWeight.w500)),
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
                                    fontWeight: FontWeight.w500)),
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
          ])),
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(
              '${AppIcons.search}',
              width: 24,
              height: 24,
            ),
          )
        ],
        // automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Menu'.toUpperCase(),
          style: TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        bottom: PreferredSize(
          child: Divider(
            height: 2,
            color: Colors.grey,
          ),
          preferredSize: Size.fromHeight(1),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Card(
                elevation: 2,
                child: Container(
                  width: screenWidth,
                  // height: screenHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'Setting',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                          title: Text(
                            'Facebook',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Instagram',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Twitter',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'Support',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                          title: Text(
                            'Rate Us',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Check For Update',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Report a problem',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Invite friends',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'About',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ListTile(
                          title: Text(
                            'About Us',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Terms & Conditions',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Privacy Policy',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Contact Us',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
