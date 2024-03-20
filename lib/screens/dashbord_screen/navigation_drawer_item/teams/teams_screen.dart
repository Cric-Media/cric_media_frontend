// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_images.dart';
import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/admin/admin_cubit.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/models/admin.dart';
import 'package:cricket_app/models/team.dart';
import 'package:cricket_app/utils/app_dialog.dart';
import 'package:cricket_app/utils/snackbars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:searchable_listview/searchable_listview.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  List<Team> teams = [];

  @override
  void initState() {
    BlocProvider.of<TeamCubit>(context).getInitialTeams();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;

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
              'Team',
              style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      fontSize: 19,
                      color: Colors.white,
                      fontWeight: FontWeight.w600)),
            ),
          ),
        ),
      ),
      body: BlocConsumer<TeamCubit, TeamState>(listener: (context, state) {
        if (state is TeamGetInitial) {
          teams = state.response.data;
        } else if (state is TeamGetError) {
          print(state.message);
        } else if (state is TeamDeleteLoading) {
          AppDialogs.loadingDialog(context);
        } else if (state is TeamDeleteError) {
          Navigator.pop(context);
          showSnack(context, message: state.message);
        } else if (state is TeamDeleteSuccess) {
          Navigator.pop(context);
          BlocProvider.of<TeamCubit>(context).getInitialTeams();
        }
      }, builder: (context, state) {
        if (state is TeamGetInitialLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SearchableList(
              // autoCompleteHints: teams.map((e) => e.name.toString()).toList(),
              searchFieldEnabled: true,
              closeKeyboardWhenScrolling: true,
              inputDecoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              initialList: teams,
              filter: (query) {
                return teams
                    .where((team) =>
                        team.name!.toLowerCase().contains(query.toLowerCase()))
                    .toList();
              },
              builder: (context, index, item) {
                return TeamTile(team: item);
              }),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            addTeam,
            arguments: {'team': null},
          );
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

class TeamTile extends StatefulWidget {
  final Team team;
  const TeamTile({Key? key, required this.team}) : super(key: key);

  @override
  State<TeamTile> createState() => _TeamTileState();
}

class _TeamTileState extends State<TeamTile> {
  List<Admin> admins = [];
  String search = '';

  // Scroll controller
  final ScrollController _scrollController = ScrollController();
  int page = 1;
  int limit = 20;

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        page++;
        BlocProvider.of<AdminCubit>(context).getMoreOtherAdmins(
          search: search,
          page: page,
          limit: limit,
        );
      }
    });
    super.initState();
  }

  void showBottomSheet(BuildContext context) {
    BlocProvider.of<AdminCubit>(context).getInitialOtherAdmins();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      useSafeArea: true,
      builder: (context) {
        return Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search Users",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
                onChanged: (value) {
                  search = value;
                  BlocProvider.of<AdminCubit>(context).getInitialOtherAdmins(
                    search: search,
                  );
                },
              ),
            ),
            Expanded(
              child: BlocConsumer<AdminCubit, AdminState>(
                listener: (context, state) {
                  if (state is AdminGetOtherAdminsSuccess) {
                    admins = state.response.data;
                  } else if (state is AdminGetOtherMoreAdminsSuccess) {
                    admins.addAll(state.response.data);
                  } else if (state is AdminShareTeamSuccess) {
                    Navigator.pop(context);
                    showSnack(context, message: state.response.message);
                  }
                },
                builder: (context, state) {
                  if (state is AdminLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    controller: _scrollController,
                    itemCount: admins.length,
                    separatorBuilder: (context, index) => const Divider(),
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: CachedNetworkImageProvider(
                            admins[index].imageUrl.toString(),
                          ),
                          onBackgroundImageError: (exception, stackTrace) =>
                              const Icon(Icons.person),
                        ),
                        title: Text(admins[index].name.toString()),

                        trailing: TextButton(
                          onPressed: () {
                            BlocProvider.of<AdminCubit>(context).shareTeam(
                              widget.team.id.toString(),
                              admins[index].id.toString(),
                            );
                          },
                          child: const Text("Share access"),
                        ),
                        // Other properties of ListTile
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 10, left: 10),
                      height: 75,
                      width: 75,
                      child: CircleAvatar(
                        backgroundImage:
                            CachedNetworkImageProvider(widget.team.image ?? ''),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  widget.team.name ?? '',
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          color: AppColor.blackColor,
                                          fontWeight: FontWeight.w700)),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'ID:${widget.team.id?.substring(0, 7)}',
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: AppColor.blackColor,
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  'Total players:${widget.team.players?.length}',
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                    fontSize: 12,
                                    color: AppColor.blackColor,
                                  )),
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Row(
                                  children: [
                                    Text("Share access"),
                                    SizedBox(width: 10),
                                    GestureDetector(
                                      onTap: () {
                                        showBottomSheet(context);
                                      },
                                      child: Image.asset(
                                        'assets/image/invite.png',
                                        width: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 5,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      addTeam,
                                      arguments: {'team': widget.team},
                                    );
                                  },
                                  child: Image.asset(AppIcons.edit, width: 20),
                                ),
                                SizedBox(height: 15),
                                GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<TeamCubit>(context)
                                        .deleteTeam(
                                      widget.team.id.toString(),
                                    );
                                  },
                                  child:
                                      Image.asset(AppIcons.delete, width: 20),
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
    );
  }
}
