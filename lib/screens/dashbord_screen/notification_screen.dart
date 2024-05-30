import 'package:cached_network_image/cached_network_image.dart';
import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/admin/admin_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    if (AdminCubit.get(context).notifiers.isEmpty) {
      AdminCubit.get(context).adminInvitations();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: AppColor.blueColor,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: RefreshIndicator(
            onRefresh: () async {
              AdminCubit.get(context).adminInvitations();
            },
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(
                            child: BlocConsumer<AdminCubit, AdminState>(
                              listener: (context, state) {
                                if (state is AdminInvitationsSuccess) {
                                  AdminCubit.get(context).notifiers =
                                      state.response.data;
                                }
                              },
                              builder: (context, state) {
                                if (state is AdminInvitationsLoading) {
                                  return ListView.builder(
                                      itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          height: 100,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                                } else if (state is AdminInvitationsError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                }
                                if (AdminCubit.get(context).notifiers.isEmpty) {
                                  return const Center(
                                    child: Text('No Notifications'),
                                  );
                                }
                                return const Notifications();
                              },
                            ),
                          ),
                        ],
                      ),
                      BlocConsumer<AdminCubit, AdminState>(
                        listener: (context, state) {
                          if (state is AdminInvitationResponseSuccess) {
                            AdminCubit.get(context).adminInvitations();
                          }
                        },
                        builder: (context, state) {
                          if (state is AdminInvitationResponseLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        final notifier = AdminCubit.get(context).notifiers[index];
        String? message;
        String? imageUrl;
        String? id;
        if (notifier.type?.toLowerCase() == "tournament") {
          message =
              'You are invited to join ${notifier.tournament?.seriesName}';
          imageUrl = notifier.tournament?.image;
          id = notifier.tournament?.sId;
        } else if (notifier.type?.toLowerCase() == "player") {
          message = 'You are invited to access ${notifier.player?.name}';
          imageUrl = notifier.player?.imageUrl;
          id = notifier.player?.id;
        } else if (notifier.type?.toLowerCase() == "team") {
          message = 'You are invited to join ${notifier.team?.name}';
          imageUrl = notifier.team?.image;
          id = notifier.team?.id;
        }
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            // color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey[400]!,
            //     blurRadius: 10,
            //     offset: const Offset(0, 2),
            //   ),
            // ],
            gradient: LinearGradient(colors: [
              AppColor.blueColor.withOpacity(0.1),
              AppColor.blueColor.withOpacity(0.2),
              AppColor.blueColor.withOpacity(0.3),
              // AppColor.blueColor.withOpacity(0.4),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 4.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notifier.type?.toUpperCase() ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColor.blueColor,
                  ),
                ),
                ListTile(
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(
                    message ?? '',
                    style: const TextStyle(fontSize: 16),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColor.blueColor,
                        foregroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            AdminCubit.get(context).invitationResponse(
                              accept: true,
                              id: id ?? '',
                              type: notifier.type ?? '',
                            );
                          },
                          icon: const Icon(Icons.check, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 8),
                      CircleAvatar(
                        backgroundColor: Colors.redAccent,
                        foregroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            AdminCubit.get(context).invitationResponse(
                              accept: false,
                              id: id ?? '',
                              type: notifier.type ?? '',
                            );
                          },
                          icon: const Icon(Icons.close, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  isThreeLine: true,
                ),
              ],
            ),
          ),
        );
      },
      itemCount: AdminCubit.get(context).notifiers.length,
    );
  }
}
