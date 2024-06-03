import 'package:cricket_app/screens/dashbord_screen/dashboard_item/home.dart';
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
      backgroundColor: const Color(0XFFFBFBFB),
      drawer: AppDrawer(screenWidth: screenWidth),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Menu'.toUpperCase(),
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 2, color: Colors.grey),
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
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'Setting',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListTile(
                          title: Text(
                            'Facebook',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Instagram',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Twitter',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'Support',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListTile(
                          title: Text(
                            'Rate Us',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Check For Update',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Report a problem',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Invite friends',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Text(
                          'About',
                          style: TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.w800),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      ListTile(
                          title: Text(
                            'About Us',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Terms & Conditions',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Privacy Policy',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      ListTile(
                          title: Text(
                            'Contact Us',
                            style: GoogleFonts.inter(
                                textStyle: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400)),
                          ),
                          trailing: const Icon(
                            Icons.arrow_right,
                            size: 30,
                          )),
                      const Divider(
                        height: 2,
                        thickness: 1,
                        color: Color(0xffA3A1A1),
                      ),
                      const SizedBox(
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
