import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/add_new_tornament.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TornamentItem extends StatelessWidget {
  const TornamentItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFBFBFB),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: Container(
          // extra container for custom bottom shadows
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 5,
                offset: Offset(0, -2),
              ),
            ],
          ),
          child: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: AppColor.blueColor,
            automaticallyImplyLeading: true,
            actions: [
              Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Image.asset(
                    AppIcons.search,
                    width: 25,
                    color: Colors.white,
                  )),
            ],
            title: Text(
              ' Tornaments',
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('ONtAP');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddNewTornament()));
        },
        backgroundColor: AppColor.blueColor,
        child: Icon(
          Icons.add,
          size: 20,
          color: Colors.white,
        ),
      ),
    );
  }
}
