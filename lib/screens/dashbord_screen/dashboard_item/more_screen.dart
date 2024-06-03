import 'package:cricket_app/cubits/social_link/social_link_cubit.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({super.key});

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  int indix = 0;

  @override
  void initState() {
    if (SocialLinkCubit.get(context).sl.isEmpty) {
      SocialLinkCubit.get(context).getSocialLink();
    }

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
        child: BlocConsumer<SocialLinkCubit, SocialLinkState>(
          listener: (context, state) {
            if (state is SocialLinkGetSuccess) {
              SocialLinkCubit.get(context).sl = state.res.data;
            }
          },
          builder: (context, state) {
            return Column(children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
                          const SizedBox(height: 5),
                          if (SocialLinkCubit.get(context).sl.isNotEmpty)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 15.0),
                                  child: Text(
                                    'Setting',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                ListView.separated(
                                  itemBuilder: (context, index) {
                                    var sl =
                                        SocialLinkCubit.get(context).sl[index];
                                    return ListTile(
                                        title: Text(
                                          sl.mediaType ?? '',
                                          style: GoogleFonts.inter(
                                              textStyle: const TextStyle(
                                                  fontSize: 17,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                        trailing: const Icon(
                                          Icons.arrow_right,
                                          size: 30,
                                        ));
                                  },
                                  separatorBuilder: (context, index) =>
                                      const Divider(),
                                  itemCount:
                                      SocialLinkCubit.get(context).sl.length,
                                  shrinkWrap: true,
                                ),
                              ],
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
            ]);
          },
        ),
      ),
    );
  }
}
