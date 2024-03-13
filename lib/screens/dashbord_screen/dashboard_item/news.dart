import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/custom_widgets/news_card.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/match_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/player_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/profile_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/teamsitem.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/tornament_item.dart';
import 'package:cricket_app/screens/dashbord_screen/new_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    int indix = 0;

    void indexes(value) {
      setState(() {
        indix = value;
      });
    }

    return Scaffold(
      backgroundColor: Color(0XFFFBFBFB),
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
        // automaticallyImplyLeading:
        //     false, // You might want to set this to true if you want the drawer icon
        centerTitle: true,
        title: Text(
          'News'.toUpperCase(),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(
              height: 7,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => NewsDetails()));
                        },
                        child: NewsCard()),
                  );
                },
              ),
            ),
            SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }
}
