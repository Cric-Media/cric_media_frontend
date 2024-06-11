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
  State<MatchItem> createState() => _MatchItemState();
}

class _MatchItemState extends State<MatchItem> {
  int _selectedIndex = 0; // Track the selected index

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Adjusted to match the tabs length
      child: Scaffold(
        backgroundColor: const Color(0XFFFBFBFB),
        appBar: AppBar(
          foregroundColor: Colors.white,
          backgroundColor: AppColor.blueColor,
          bottom: TabBar(
            onTap: (index) {
              setState(() {
                _selectedIndex = index; // Update selected index
              });
            },

            labelColor: Colors.white,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),

            tabs: List.generate(
              3,
              (index) => Tab(
                child: Container(
                  decoration: _selectedIndex == index
                      ? BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        )
                      : null,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Text(
                    ["Live", "Upcoming", "Complete"][index], // Tab text
                    style: TextStyle(
                        color: _selectedIndex == index
                            ? Colors.black
                            : Colors.white), // Text color based on selection
                  ),
                ),
              ),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            // Set indicator color to transparent to remove it
            indicatorColor: Colors.transparent,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.w800,
            ),
          ),
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.only(right: 20.0),
          //     child: Icon(Icons.search), // Simplified for the example
          //   ),
          // ],
          title: Text(
            'Matches',
            style: GoogleFonts.inter(
              textStyle: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            LiveItem(),
            UpComingItem(),
            CompleteItem(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, addMatch, arguments: {
              "match": null,
            });
          },
          backgroundColor: AppColor.blueColor,
          child: const Icon(
            Icons.add,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
