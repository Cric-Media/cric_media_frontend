import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/change_password_screen.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/forget_password.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/verify_email_for_password_screen.dart';
import 'package:cricket_app/screens/auth_screen/sigin_screen/signIn.dart';
import 'package:cricket_app/screens/auth_screen/signUp_screen/signUp_screen.dart';
import 'package:cricket_app/screens/auth_screen/signUp_screen/verify_email_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/add_new_player_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/add_new_matche.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/player_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/add_new_team.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/team_players_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/teams_screen.dart';
import 'package:cricket_app/screens/splash_screen.dart/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case index:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SplashScreen(),
          ),
        );

      case signup:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SignUpScreen(),
          ),
        );

      case verifyEmail:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const VerifyEmailScreen(),
          ),
        );

      case signin:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const SigninScreen(),
          ),
        );

      case forgetPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const ForgetPassword(),
          ),
        );

      case verifyEmailForPassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const VerifyEmailForPasswordScreen(),
          ),
        );

      case changePassword:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => AuthCubit(),
            child: const ChangePasswordScreen(),
          ),
        );

      case dashboard:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AuthCubit(),
              ),
              BlocProvider<MatchCubit>(create: (context) => MatchCubit()),
            ],
            child: const DashBoardScreen(),
          ),
        );

      case playerItem:
        return MaterialPageRoute(
          builder: (context) => const PlayerItem(),
        );

      case addNewPlayer:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => AddNewPlayerScreen(
            playerId: args['playerId'],
          ),
        );

      case teams:
        return MaterialPageRoute(builder: (context) => const TeamsScreen());

      case addTeam:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => AddNewTeam(
            team: args['team'],
          ),
        );

      case startMatch:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MatchCubit>(
            create: (context) => MatchCubit(),
            child: const AddNewMatche(),
          ),
        );

      case teamPlayers:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<PlayerCubit>(
            create: (context) => PlayerCubit()
              ..getPlayersByTeamId(
                args['teamId'],
              ),
            child: const TeamPlayersScreen(),
          ),
        );

      default:
        return null;
    }
  }
}
