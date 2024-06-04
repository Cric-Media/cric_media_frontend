import 'package:cricket_app/cubits/admin/admin_cubit.dart';
import 'package:cricket_app/cubits/auth/auth_cubit.dart';
import 'package:cricket_app/cubits/match/match_cubit.dart';
import 'package:cricket_app/cubits/news/news_cubit.dart';
import 'package:cricket_app/cubits/player/player_cubit.dart';
import 'package:cricket_app/cubits/social_link/social_link_cubit.dart';
import 'package:cricket_app/cubits/teams/team_cubit.dart';
import 'package:cricket_app/cubits/tournament/tournament_cubit.dart';
import 'package:cricket_app/cubits/video/video_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  BlocProvider<AdminCubit>(create: (context) => AdminCubit()),
  BlocProvider<PlayerCubit>(create: (context) => PlayerCubit()),
  BlocProvider<TeamCubit>(
    create: (context) => TeamCubit()..getInitialTeams(),
  ),
  BlocProvider<MatchCubit>(create: (context) => MatchCubit()),
  BlocProvider<TournamentCubit>(
    create: (context) => TournamentCubit(),
  ),
  BlocProvider<AuthCubit>(create: (context) => AuthCubit()),
  BlocProvider<MatchCubit>(
    create: (context) => MatchCubit()
      ..getLiveMatches(
        user: true,
      ),
  ),
  BlocProvider<NewsCubit>(create: (context) => NewsCubit()),
  BlocProvider<SocialLinkCubit>(create: (context) => SocialLinkCubit()),
  BlocProvider<VideoCubit>(create: (context) => VideoCubit()),
];
