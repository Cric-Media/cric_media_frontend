// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/complete_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/live_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/upcoming_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchItem extends StatefulWidget {
  const MatchItem({Key? key}) : super(key: key);

  @override
  _MatchItemState createState() => _MatchItemState();
}

class _MatchItemState extends State<MatchItem> {
  int _selectedIndex = 0; // Track the selected index

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Adjusted to match the tabs length
      child: Scaffold(
        backgroundColor: Color(0XFFFBFBFB),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.blueColor,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index; // Update selected index
              });
            },
            // Removed dividerHeight and dividerColor since we're customizing the tabs directly
            labelColor: Colors.white,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w800,
            ),
            tabs: List.generate(
                3,
                (index) => Tab(
                      child: Container(
                        decoration: _selectedIndex == index
                            ? BoxDecoration(
                                color: Colors
                                    .white, // Your selected tab background color
                                borderRadius: BorderRadius.circular(
                                    10), // Rounded corners
                              )
                            : null,
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: Text(
                          ["Live", "Upcoming", "Complete"][index], // Tab text
                          style: TextStyle(
                              color: _selectedIndex == index
                                  ? Colors.black
                                  : Colors
                                      .white), // Text color based on selection
                        ),
                      ),
                    )),
            indicatorSize: TabBarIndicatorSize.tab,
            // Set indicator color to transparent to remove it
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.search), // Simplified for the example
            ),
          ],
          title: Text(
            'Matches',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            LiveItem(),
            UpComingItem(),
            CompleteItem(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            print('ONtAP');
            Navigator.pushNamed(context, startMatch);
          },
          backgroundColor: AppColor.blueColor,
          child: Icon(
            Icons.add,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
