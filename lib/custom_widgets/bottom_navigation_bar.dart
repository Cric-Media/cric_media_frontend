import 'package:cricket_app/constants/app_color.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const BottomNavBar(
      {required this.selectedIndex, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.090,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(12),
          topLeft: Radius.circular(12),
        ),
      ),
      child: Row(
        children: [
          buildMenuItem(context, 0, 'Home', 'assets/icons/Home.png'),
          buildMenuItem(context, 1, 'News', 'assets/icons/News.png'),
          buildMenuItem(context, 2, 'Series', 'assets/icons/Series.png'),
          buildMenuItem(context, 3, 'Video', 'assets/icons/Video.png'),
          buildMenuItem(context, 4, 'Menu', 'assets/icons/more.png'),
        ],
      ),
    );
  }

  Expanded buildMenuItem(context, int index, String title, String iconPath) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                color: selectedIndex == index
                    ? AppColor.blueColor
                    : Colors.grey.withOpacity(0.8),
                width: selectedIndex == index
                    ? MediaQuery.of(context).size.width * 0.058
                    : MediaQuery.of(context).size.width * 0.056,
                fit: BoxFit.contain,
              ),
              Text(
                title,
                style: TextStyle(
                  fontFamily: 'public',
                  fontSize: MediaQuery.of(context).size.width * 0.03,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
