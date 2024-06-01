// import 'package:cricket_app/constants/routes_names.dart';
// import 'package:cricket_app/cubits/auth/auth_cubit.dart';
// import 'package:cricket_app/cubits/match/match_cubit.dart';
// import 'package:cricket_app/cubits/player/player_cubit.dart';
// import 'package:cricket_app/models/tournament.dart';
// import 'package:cricket_app/screens/auth_screen/forget_password/change_password_screen.dart';
// import 'package:cricket_app/screens/auth_screen/forget_password/forget_password.dart';
// import 'package:cricket_app/screens/auth_screen/forget_password/verify_email_for_password_screen.dart';
// import 'package:cricket_app/screens/auth_screen/sigin_screen/signIn.dart';
// import 'package:cricket_app/screens/auth_screen/signUp_screen/signUp_screen.dart';
// import 'package:cricket_app/screens/auth_screen/signUp_screen/verify_email_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/dashboard_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/home_tab_item/series_details_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/add_new_player_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/add_match_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/live_scorer_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/match_item.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/set_openings_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/start_match_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/player_item.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/add_new_team.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/team_players_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/teams_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/add_new_tornament.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/add_tournament_match_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/tournament_details_screen.dart';
// import 'package:cricket_app/screens/dashbord_screen/notification_screen.dart';
// import 'package:cricket_app/screens/splash_screen.dart/splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class Routes {
//   static Route? onGenerateRoute(RouteSettings settings) {
//     WidgetBuilder builder;
//     switch (settings.name) {
//       case index:
//         builder = (context) => BlocProvider(
//               create: (context) => AuthCubit(),
//               child: const SplashScreen(),
//             );
//         break;

//       case signup:
//         builder = (context) => BlocProvider(
//               create: (context) => AuthCubit(),
//               child: const SignUpScreen(),
//             );
//         break;

//       case verifyEmail:
//         builder = (context) => BlocProvider(
//               create: (context) => AuthCubit(),
//               child: const VerifyEmailScreen(),
//             );
//         break;

//       case signin:
//         builder = (context) => BlocProvider(
//               create: (context) => AuthCubit(),
//               child: const SigninScreen(),
//             );
//         break;

//       case forgetPassword:
//         builder = (context) => BlocProvider(
//               create: (context) => AuthCubit(),
//               child: const ForgetPassword(),
//             );
//         break;

//       case verifyEmailForPassword:
//         builder = (context) => BlocProvider(
//               create: (context) => AuthCubit(),
//               child: const VerifyEmailForPasswordScreen(),
//             );
//         break;

//       case changePassword:
//         builder = (context) => BlocProvider(
//               create: (context) => AuthCubit(),
//               child: const ChangePasswordScreen(),
//             );
//         break;

//       case dashboard:
//         builder = (context) => MultiBlocProvider(
//               providers: [
//                 BlocProvider(
//                   create: (context) => AuthCubit(),
//                 ),
//                 BlocProvider<MatchCubit>(
//                   create: (context) => MatchCubit()..getLiveMatches(user: true),
//                 ),
//               ],
//               child: const DashBoardScreen(),
//             );
//         break;

//       case playerItem:
//         builder = (context) => const PlayerItem();
//         break;

//       case addNewPlayer:
//         final args = settings.arguments as Map<String, dynamic>;
//         builder = (context) => AddNewPlayerScreen(
//               playerId: args['playerId'],
//             );
//         break;

//       case teams:
//         builder = (context) => const TeamsScreen();
//         break;

//       case addTeam:
//         final args = settings.arguments as Map<String, dynamic>;
//         builder = (context) => AddNewTeam(
//               team: args['team'],
//             );
//         break;

//       case addMatch:
//         builder = (context) => BlocProvider<MatchCubit>(
//               create: (context) => MatchCubit(),
//               child: const AddMatchScreen(),
//             );
//         break;

//       case startMatch:
//         final args = settings.arguments as Map<String, dynamic>;
//         builder = (context) => BlocProvider<MatchCubit>(
//               create: (context) => MatchCubit(),
//               child: StartMatchScreen(match: args['match']),
//             );
//         break;

//       case teamPlayers:
//         final args = settings.arguments as Map<String, dynamic>;
//         builder = (context) => BlocProvider<PlayerCubit>(
//               create: (context) =>
//                   PlayerCubit()..getPlayersByTeamId(args['teamId']),
//               child: const TeamPlayersScreen(),
//             );
//         break;

//       case setOpenings:
//         final args = settings.arguments as Map<String, dynamic>;
//         builder = (context) => SetOpeningsScreen(
//               matchId: args['matchId'],
//               teamABatting: args['teamABatting'],
//               teamBBatting: args['teamBBatting'],
//               teamAId: args['teamAId'],
//               teamBId: args['teamBId'],
//               squad1: args['squad1'],
//               squad2: args['squad2'],
//             );
//         break;

//       case liveScorer:
//         final args = settings.arguments as Map<String, dynamic>;
//         builder = (context) => LiveScorerScreen(matchId: args['matchId']);
//         break;

//       case adminMatches:
//         builder = (context) => const MatchItem();
//         break;

//       case addTournament:
//         final Tournament? tournament = settings.arguments as Tournament?;
//         builder = (context) => AddNewTornament(tournament: tournament);
//         break;

//       case tournamentDetails:
//         final tournament = settings.arguments as Tournament;
//         builder = (context) => TournamentDetailsScreen(
//               tournament: tournament,
//             );
//         break;

//       case notification:
//         builder = (context) => const NotificationScreen();
//         break;

//       case addTournamentMatch:
//         final args = settings.arguments as Map<String, dynamic>;
//         final tournament = args['tournament'];
//         final groupId = args['groupId'];
//         final totalMatches = args['totalMatches'];
//         builder = (context) => BlocProvider<MatchCubit>(
//               create: (context) => MatchCubit(),
//               child: AddTournamentMatchScreen(
//                 tournament: tournament!,
//                 groupId: groupId,
//                 totalMatches: totalMatches,
//               ),
//             );
//         break;

//       case seriesDetails:
//         final tournamentId = settings.arguments as String?;
//         builder = (context) => SeriesDetailsScreen(
//               tournamentId: tournamentId,
//             );
//         break;

//       default:
//         return null;
//     }

//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => builder(context),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0); // Slide from right
//         const end = Offset.zero;
//         const curve = Curves.ease;

//         var tween =
//             Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   }
// }

import 'package:cricket_app/constants/routes_names.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/models/tournament.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/change_password_screen.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/forget_password.dart';
import 'package:cricket_app/screens/auth_screen/forget_password/verify_email_for_password_screen.dart';
import 'package:cricket_app/screens/auth_screen/sigin_screen/signIn.dart';
import 'package:cricket_app/screens/auth_screen/signUp_screen/signUp_screen.dart';
import 'package:cricket_app/screens/auth_screen/signUp_screen/verify_email_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/dashboard_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/home_tab_item/series_details_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/add_new_player_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/add_match_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/live_scorer_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/match_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/set_openings_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/matches/start_match_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/player_item.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/add_new_team.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/team_players_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/teams/teams_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/add_new_tornament.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/add_tournament_match_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/navigation_drawer_item/tornaments/tournament_details_screen.dart';
import 'package:cricket_app/screens/dashbord_screen/notification_screen.dart';
import 'package:cricket_app/screens/splash_screen.dart/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static removeAllRoutes(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

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
              BlocProvider<MatchCubit>(
                create: (context) => MatchCubit()
                  ..getLiveMatches(
                    user: true,
                  ),
              ),
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

      case addMatch:
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MatchCubit>(
            create: (context) => MatchCubit(),
            child: const AddMatchScreen(),
          ),
        );

      case startMatch:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MatchCubit>(
            create: (context) => MatchCubit(),
            child: StartMatchScreen(match: args['match']),
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

      case setOpenings:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => SetOpeningsScreen(
            matchId: args['matchId'],
            teamABatting: args['teamABatting'],
            teamBBatting: args['teamBBatting'],
            teamAId: args['teamAId'],
            teamBId: args['teamBId'],
            squad1: args['squad1'],
            squad2: args['squad2'],
          ),
        );

      case liveScorer:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) => LiveScorerScreen(matchId: args['matchId']),
        );

      case adminMatches:
        return MaterialPageRoute(
          builder: (context) => const MatchItem(),
        );

      // Tournaments
      case addTournament:
        final Tournament? tournament = settings.arguments as Tournament?;
        return MaterialPageRoute(
          builder: (context) => AddNewTornament(tournament: tournament),
        );

      case tournamentDetails:
        final tournament = settings.arguments as Tournament;
        return MaterialPageRoute(
          builder: (context) => TournamentDetailsScreen(
            tournament: tournament,
          ),
        );

      case notification:
        return MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        );

      case addTournamentMatch:
        final args = settings.arguments as Map<String, dynamic>;
        final tournament = args['tournament'];
        final groupId = args['groupId'];
        final totalMatches = args['totalMatches'];
        final matchType = args['matchType'];
        return MaterialPageRoute(
          builder: (context) => BlocProvider<MatchCubit>(
            create: (context) => MatchCubit(),
            child: AddTournamentMatchScreen(
              tournament: tournament!,
              groupId: groupId,
              totalMatches: totalMatches,
              matchType: matchType,
            ),
          ),
        );

      case seriesDetails:
        final args = settings.arguments as Map<String, dynamic>;
        final tournamentId = args['id'];
        return MaterialPageRoute(
          builder: (context) => SeriesDetailsScreen(
            tournamentId: tournamentId,
          ),
        );

      default:
        return null;
    }
  }
}
