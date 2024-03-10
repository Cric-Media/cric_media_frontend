import 'package:cricket_app/constent/app_images.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/up_coming_series_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/match_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/player_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/profile_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/teamsitem.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/tornament_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Series extends StatefulWidget {
  const Series({super.key});

  @override
  State<Series> createState() => _SeriesState();
}

class _SeriesState extends State<Series> {
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
      drawer: Container(
        child: Drawer(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileItem()));
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayerItem()));
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
      ),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Series'.toUpperCase(),
          style: GoogleFonts.inter(
              textStyle: TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
        ),
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
      ),
      body: Column(children: [
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpCommingSeriesScreen()));
                    },
                    child: Card(
                      elevation: 2,
                      color: Colors.white,
                      child: Container(
                          height: 82,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    AppIcons.cup2,
                                    height: 70,
                                    color: Colors.black,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        'South Africa vs England',
                                        style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Text('Start Date  2024/2/30',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400)),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        children: [
                                          Text('End Date  2024/3/17',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
                                          SizedBox(
                                            width: 140,
                                          ),
                                          Column(
                                            children: [
                                              Text('3rd 20T',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              Text('3rd ODI',
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400))
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    ),
                  ),
                );
              }),
        )
      ]),
    );
  }
}
