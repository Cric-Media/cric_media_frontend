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
    const Video(),
    const Series(),
    const Menu(),
    Container(),
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

  getVlaue(int x) {
    value = x;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0XFFFBFBFB),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          value == 0
              ? const Home()
              : value == 1
                  ? const News()
                  : value == 2
                      ? const Series()
                      : value == 3
                          ? const Video()
                          : value == 4
                              ? const Menu()
                              : Container(),
          const SizedBox(
            height: 4,
          ),
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: size.height * 0.080,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12)),
                  ),
                  child: Row(children: [
                    GestureDetector(
                        onTap: () {
                          getVlaue(0);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          width: size.width * 0.15,
                          height: size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                'assets/icons/Home.png',
                                color: value == 0
                                    ? AppColor.blueColor
                                    : Colors.grey.withOpacity(0.8),
                                width: value == 0
                                    ? size.width * 0.058
                                    : size.width * 0.056,
                              ),
                              Text(
                                'Home',
                                style: TextStyle(
                                  fontFamily: 'public',
                                  fontSize: size.width * 0.03,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )),
                    GestureDetector(
                      onTap: () {
                        getVlaue(1);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 15),
                        width: size.width * 0.15,
                        height: size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Image.asset(
                              'assets/icons/News.png',
                              width: value == 1
                                  ? size.width * 0.058
                                  : size.width * 0.056,
                              color: value == 1
                                  ? AppColor.blueColor
                                  : Colors.grey.withOpacity(0.8),
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'News',
                              style: TextStyle(
                                fontFamily: 'public',
                                fontSize: size.width * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          getVlaue(2);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 15),
                          width: size.width * 0.15,
                          height: size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              Image.asset(
                                'assets/image/tornament.png',
                                color: value == 2
                                    ? AppColor.blueColor
                                    : Colors.grey.withOpacity(0.8),
                                width: value == 2
                                    ? size.width * 0.058
                                    : size.width * 0.056,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Series',
                                style: TextStyle(
                                  fontFamily: 'public',
                                  fontSize: size.width * 0.03,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )),
                    GestureDetector(
                        onTap: () {
                          getVlaue(3);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(left: 15),
                          width: size.width * 0.15,
                          height: size.height,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              Image.asset(
                                'assets/icons/Video.png',
                                color: value == 3
                                    ? AppColor.blueColor
                                    : Colors.grey.withOpacity(0.8),
                                width: value == 3
                                    ? size.width * 0.058
                                    : size.width * 0.056,
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                'Video',
                                style: TextStyle(
                                  fontFamily: 'public',
                                  fontSize: size.width * 0.03,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        )),
                    GestureDetector(
                      onTap: () {
                        getVlaue(4);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 15),
                        width: size.width * 0.15,
                        height: size.height,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Image.asset(
                              'assets/icons/more.png',
                              color: value == 4
                                  ? AppColor.blueColor
                                  : Colors.grey.withOpacity(0.8),
                              width: value == 4
                                  ? size.width * 0.058
                                  : size.width * 0.056,
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Menu',
                              style: TextStyle(
                                fontFamily: 'public',
                                fontSize: size.width * 0.03,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
