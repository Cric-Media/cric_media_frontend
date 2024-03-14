// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/models/get_player_list.dart';
import 'package:cricket_app/providers/get_all_player_provider.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/add_new_player_Screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PlayerItem extends StatefulWidget {
  PlayerItem({super.key});

  @override
  State<PlayerItem> createState() => _PlayerItemState();
}

class _PlayerItemState extends State<PlayerItem> {
  @override
  void initState() {
    super.initState();
  }

  String? userId;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    print(' player list ===>>>> screen');
    return ChangeNotifierProvider(
      create: (BuildContext context) => GetAllPlayerProvider(),
      child: Consumer<GetAllPlayerProvider>(
        builder: (context, value, child) {
          return Scaffold(
            backgroundColor: Color(0XFFFBFBFB),
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Container(
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
                    ' Players',
                    style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            fontSize: 19,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
            body: Stack(
              children: [
                StreamBuilder<List<getPlayerList>>(
                  stream: value.playersStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text("SNAPSHORT ERROR"),
                      );
                    } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                      return Center(child: Text('No player  found'));
                    } else if (snapshot.hasData) {
                      final player = snapshot.data!;
                      return ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: player.length,
                        padding:
                            EdgeInsets.only(top: 10), // Adjusted for simplicity
                        itemBuilder: (context, index) {
                          final playerDetails = player[index];
                          int? itemid = player[index].id;
                          print(
                              ' player image ===>>>>> ${playerDetails.image}');
                          // print(
                          //     " image url ===>>>>>> ui  ${value.b + playerDetails.image.toString()}");

                          print(
                              "get all player list screen lenght====<<<<<${player.length}");

                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: screenWidth,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.7),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 120,
                                              width: 130,
                                              decoration: BoxDecoration(),
                                              child: Image.file(
                                                File(playerDetails
                                                    .image!), // Assuming `playerDetails.image` is a String path to your image.
                                                fit: BoxFit.cover,
                                                errorBuilder: (BuildContext
                                                        context,
                                                    Object exception,
                                                    StackTrace? stackTrace) {
                                                  print(
                                                      "Image error: $exception"); // Print the error message
                                                  return Icon(Icons
                                                      .error); // Display an error icon
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              flex: 3,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10,
                                                                top: 5),
                                                        child: Text(
                                                          '#${(player.length - index).toString()}',
                                                          style:
                                                              GoogleFonts.inter(
                                                            textStyle:
                                                                TextStyle(
                                                              fontSize: 17,
                                                              color: AppColor
                                                                  .grayColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 2,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0),
                                                        child: Text(
                                                          '${playerDetails.name}',
                                                          style: GoogleFonts.inter(
                                                              textStyle: TextStyle(
                                                                  fontSize: 16,
                                                                  color: AppColor
                                                                      .blackColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                left: 10.0),
                                                        child: Text(
                                                          'Role: ${playerDetails.type}',
                                                          style: GoogleFonts.inter(
                                                              textStyle: TextStyle(
                                                                  fontSize: 15,
                                                                  color: AppColor
                                                                      .blackColor,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    left: 10.0),
                                                            child: Text(
                                                              'ID:${'12332'}',
                                                              style: GoogleFonts.inter(
                                                                  textStyle: TextStyle(
                                                                      fontSize:
                                                                          15,
                                                                      color: AppColor
                                                                          .blackColor,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w600)),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 100,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    top: 5),
                                                            child: Image.asset(
                                                              'assets/image/invite.png',
                                                              width: 20,
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                      // Padding(
                                                      //   padding: EdgeInsets.only(right: 10.0),
                                                      //   child: Image.asset(
                                                      //     AppIcons.edit,
                                                      //     width: 30,
                                                      //   ),
                                                      // )
                                                    ],
                                                  ),
                                                  // Row(
                                                  //   mainAxisAlignment:
                                                  //       MainAxisAlignment.spaceBetween,
                                                  //   children: [
                                                  //     Padding(
                                                  //       padding: const EdgeInsets.only(
                                                  //           right: 10.0, top: 5),
                                                  //       child: Image.asset(
                                                  //         AppIcons.delete,
                                                  //         width: 30,
                                                  //       ),
                                                  //     )
                                                  //   ],
                                                  // ),
                                                  Spacer(),

                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Image.asset(
                                                          AppIcons.edit,
                                                          width: 20,
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            print(
                                                                ' player id =====> ${itemid}');
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                  title: Text(
                                                                      "Delete Player"),
                                                                  content: Text(
                                                                      "Are you sure you want to delete this player?"),
                                                                  actions: <Widget>[
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop(); // Close the dialog
                                                                      },
                                                                      child: Text(
                                                                          "Cancel"),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                        // value.setLoading(
                                                                        //     true);
                                                                        // Close the dialog
                                                                      },
                                                                      child: Text(
                                                                          "Delete"),
                                                                    ),
                                                                  ],
                                                                );
                                                              },
                                                            );
                                                          },
                                                          child: Image.asset(
                                                            AppIcons.delete,
                                                            width: 20,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: 15,
                                                        ),
                                                        Image.asset(
                                                          AppIcons.add,
                                                          width: 20,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      // Fallback for any other unexpected scenario
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                if (value.isLoading) // Show indicator if loading
                  Positioned.fill(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                print('ONtAP');
                // DBHelper().deleteAll();
                // DBHelper().printAllDataAndCheckEmpty();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddNewPlayerScreen()));
              },
              backgroundColor: AppColor.blueColor,
              child: Icon(
                Icons.add,
                size: 20,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
