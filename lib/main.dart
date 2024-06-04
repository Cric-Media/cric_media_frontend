import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/admin/admin_cubit.dart';
import 'package:cricket_app/cubits/news/news_cubit.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/cubits/social_link/social_link_cubit.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/providers/add_new_player_provider.dart';
import 'package:cricket_app/providers/registration_provider.dart';
import 'package:cricket_app/providers/team_provider.dart';
import 'package:cricket_app/providers/user_login_provider.dart';
import 'package:cricket_app/routes.dart';
import 'package:cricket_app/services/socket_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';

import 'cubits/match/match_cubit.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SocketService.instance.connect();
  MobileAds.instance.initialize();
  // MobileAds.instance.updateRequestConfiguration(
  //     RequestConfiguration(testDeviceIds: ['YOUR_TEST_DEVICE_ID']));

  // // Register the native ad factory
  // MobileAds.instance.updateRequestConfiguration(
  //   RequestConfiguration(
  //     tagForChildDirectedTreatment: TagForChildDirectedTreatment.yes,
  //     tagForUnderAgeOfConsent: TagForUnderAgeOfConsent.yes,
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserLoginProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider(create: (context) => AddNewPlayerProvider()),
        ChangeNotifierProvider(create: (context) => TeamProvider()),
      ],
      child: GestureDetector(
        onTap: () {
          // hide keyboard whenever we click on the any part of the app
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AdminCubit>(create: (context) => AdminCubit()),
            BlocProvider<PlayerCubit>(create: (context) => PlayerCubit()),
            BlocProvider<TeamCubit>(
              create: (context) => TeamCubit()..getInitialTeams(),
            ),
            BlocProvider<MatchCubit>(create: (context) => MatchCubit()),
            BlocProvider<TournamentCubit>(
              create: (context) => TournamentCubit(),
            ),
            BlocProvider<NewsCubit>(create: (context) => NewsCubit()),
            BlocProvider<SocialLinkCubit>(
                create: (context) => SocialLinkCubit()),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cric Media',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColor.blueColor),
              useMaterial3: true,
              // ).copyWith(
              //   appBarTheme: const AppBarTheme(
              //     backgroundColor: AppColor.blueColor,
              //     foregroundColor: Colors.white,
              //   ),
            ),
            onGenerateRoute: Routes.onGenerateRoute,
            initialRoute: '/',
          ),
        ),
      ),
    );
  }
}
