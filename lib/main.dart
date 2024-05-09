import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/cubits/admin/admin_cubit.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/providers/add_new_player_provider.dart';
import 'package:cricket_app/providers/registration_provider.dart';
import 'package:cricket_app/providers/team_provider.dart';
import 'package:cricket_app/providers/user_login_provider.dart';
import 'package:cricket_app/routes.dart';
import 'package:cricket_app/services/socket_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SocketService.instance.connect();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
            BlocProvider<MatchCubit>(
              create: (context) => MatchCubit()..getLiveMatches(user: true),
            ),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Cric Media',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: AppColor.blueColor),
              useMaterial3: true,
            ),
            onGenerateRoute: Routes.onGenerateRoute,
            initialRoute: '/',
          ),
        ),
      ),
    );
  }
}
