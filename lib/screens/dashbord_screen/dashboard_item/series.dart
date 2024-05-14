import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/home.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/up_coming_series_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Series extends StatelessWidget {
  const Series({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      drawer: AppDrawer(screenWidth: screenWidth),
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: Text(
          'Series'.toUpperCase(),
          style: GoogleFonts.inter(
              textStyle: const TextStyle(
                  fontSize: 17,
                  color: Colors.black,
                  fontWeight: FontWeight.w700)),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset(
              AppIcons.search,
              width: 24,
              height: 24,
            ),
          )
        ],
      ),
      body: Column(children: [
        const SizedBox(
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
                              builder: (context) =>
                                  const UpCommingSeriesScreen()));
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
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        'South Africa vs England',
                                        style: GoogleFonts.inter(
                                            textStyle: const TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      const Text('Start Date  2024/2/30',
                                          style: TextStyle(
                                              fontSize: 11,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400)),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      const Row(
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
