import 'package:cricket_app/screens/dashbord_screen/dashboard_item/home.dart';
import 'package:flutter/material.dart';

class News extends StatefulWidget {
  const News({Key? key}) : super(key: key);

  @override
  State<News> createState() => _NewsState();
}

class _NewsState extends State<News> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0XFFFBFBFB),
      appBar: AppBar(
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20.0),
        //     child: Image.asset(
        //       '${AppIcons.search}',
        //       width: 24,
        //       height: 24,
        //     ),
        //   )
        // ],
        // automaticallyImplyLeading:
        //     false, // You might want to set this to true if you want the drawer icon
        centerTitle: true,
        title: Text(
          'News'.toUpperCase(),
          style: const TextStyle(
              fontSize: 20, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            height: 2,
            color: Colors.grey,
          ),
        ),
      ),
      drawer: AppDrawer(screenWidth: screenWidth),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "This feature will be available soon in the app.",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            )
            // const SizedBox(
            //   height: 7,
            // ),
            // Expanded(
            //   child: ListView.builder(
            //     itemCount: 10,
            //     itemBuilder: (context, index) {
            //       return Padding(
            //         padding: const EdgeInsets.symmetric(vertical: 5.0),
            //         child: InkWell(
            //             onTap: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => const NewsDetails()));
            //             },
            //             child: const NewsCard()),
            //       );
            //     },
            //   ),
            // ),
            // const SizedBox(
            //   height: 70,
            // ),
          ],
        ),
      ),
    );
  }
}
