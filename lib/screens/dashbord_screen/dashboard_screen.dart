import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/home.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/menu.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/news.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/series.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_item/video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _MainPageState();
}

class _MainPageState extends State<DashBoardScreen> {
  List<Widget> screens = [
    const Home(),
    const News(),
    const Series(),
    const Video(),
    const Menu(),
  ];

  int value = 0;

  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).getUser();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {});
    });
    super.initState();
  }

  void getVlaue(int x) {
    value = x;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      // backgroundColor: const Color(0XFFFBFBFB),
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          screens[value],
          const SizedBox(height: 4),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(12),
                topLeft: Radius.circular(12),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem('Home', 'assets/icons/Home.png', 0),
                _buildNavItem('News', 'assets/icons/News.png', 1),
                _buildNavItem('Series', 'assets/icons/Series.png', 2),
                _buildNavItem('Video', 'assets/icons/Video.png', 3),
                _buildNavItem('Menu', 'assets/icons/more.png', 4),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String label, String iconPath, int index) {
    return GestureDetector(
      onTap: () {
        getVlaue(index);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              iconPath,
              color: value == index
                  ? AppColor.blueColor
                  : Colors.grey.withOpacity(0.8),
              width: 24,
              height: 24,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'public',
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: value == index
                    ? AppColor.blueColor
                    : Colors.grey.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
