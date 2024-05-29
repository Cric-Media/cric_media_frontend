import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppUrl {
  static String developmentUrl = dotenv.env['DEVELOPMENT_URL']!;
  static String productionUrl = dotenv.env['PRODUCTION_URL']!;

  static String baseUrl = developmentUrl;
}

abstract class AuthUrl {
  static final sendOtpForSignup = "${AppUrl.baseUrl}/signup";
  static final verifyEmailAndSignup = "${AppUrl.baseUrl}/emailVrifyOtp";
  static final signin = "${AppUrl.baseUrl}/Login";
  static final getUser = "${AppUrl.baseUrl}/get-user-detail";
  static final sendOtpForPasswordChange =
      "${AppUrl.baseUrl}/send-otp-forpassword-change";
  static final verifyOtpForPasswordChange =
      "${AppUrl.baseUrl}/password-otp-varify";
  static final changePassword = "${AppUrl.baseUrl}/changePassword";
}

abstract class AdminUrl {
  static final addPlayer = '${AppUrl.baseUrl}/add-players';
  static final getAllPlayers = '${AppUrl.baseUrl}/get-player-detail-by-adminid';
  static final getAllPlayersByTeamId =
      '${AppUrl.baseUrl}/get-players-by-teamId';
  // static final getPlayerDetail =
  //     '${AppUrl.baseUrl}/get-player-detail-by-playerid';
  static final updatePlayer = '${AppUrl.baseUrl}/update-player';
  static final deletePlayer = '${AppUrl.baseUrl}/delete-player-byid';
  static final getOtherAdmins = '${AppUrl.baseUrl}/get-other-admin-by-adminid';
  static final sharePlayer = '${AppUrl.baseUrl}/share-player';
  static final shareTeam = '${AppUrl.baseUrl}/share-team';
  static final adminInvitations = "${AppUrl.baseUrl}/admin/invitations";
  static final invitationResponse = "${AppUrl.baseUrl}/access/response";

  // Team URLs
  static final createTeam = '${AppUrl.baseUrl}/add-team';
  static final getTeams = '${AppUrl.baseUrl}/get-teams';
  static final updateTeam = '${AppUrl.baseUrl}/update-team';
  static final deleteTeam = '${AppUrl.baseUrl}/delete-team-byid';
  static final addPlayerToTeam = '${AppUrl.baseUrl}/in-team-add-player';

  // * MATCH URLs
  static final addMatchDetails = "${AppUrl.baseUrl}/add-match-details";
  static final getUncomingMatchesByAdmin =
      "${AppUrl.baseUrl}/get-upcoming-matches";
  static final getUpcomingMatches =
      "${AppUrl.baseUrl}/get-upcoming-matches-for-user";
  static final getLiveMatches = "${AppUrl.baseUrl}/get-live-matches-for-user";
  static final getLiveAdminMatches = "${AppUrl.baseUrl}/get-live-matches";
  static final startMatch = "${AppUrl.baseUrl}/start-match";
  static final getMatch = "${AppUrl.baseUrl}/get-match-details";
  static final getMatchAdmin = "${AppUrl.baseUrl}/get-matchdetails-for-admin";
  static final getCompletedMatches = "${AppUrl.baseUrl}/get-completed-matches";
  static final getCompletedMatchesByAdmin =
      "${AppUrl.baseUrl}/get-completed-matches-for-admin";
  static final startStopMatch = "${AppUrl.baseUrl}/start-stop-match";
  static final bannerMatches = "${AppUrl.baseUrl}/get-banner-matches";

  // * Live URLs
  static final setOpenings = "${AppUrl.baseUrl}/set-openings";
  static final action = "${AppUrl.baseUrl}/action";
  static final matchScoreCards = "${AppUrl.baseUrl}/get-scorecards-for-match";
  static final getMatchOvers = "${AppUrl.baseUrl}/get-overs-for-match";
  static final setManOfTheMatch = "${AppUrl.baseUrl}/set-man-of-the-match";

  // * Tournament URLs
  static final addTournament = "${AppUrl.baseUrl}/tournament";
  static final getTournaments = "${AppUrl.baseUrl}/tournaments";
  static final shareAccess = "${AppUrl.baseUrl}/access";
  static final getTournament = "${AppUrl.baseUrl}/tournament";
  static final teamToTournament = "${AppUrl.baseUrl}/team-to-tournament";
  static final addTournamentMatch = "${AppUrl.baseUrl}/add-tournament-match";
  static final tournamentUpcoming = "${AppUrl.baseUrl}/tournament/upcoming";
  static final tournamentLive = "${AppUrl.baseUrl}/tournament/live";
  static final groupToTournament = "${AppUrl.baseUrl}/group-to-tournament";
  static final teamToGroup = "${AppUrl.baseUrl}/team-to-tournament-group";
  static final removeGroupTeam = "${AppUrl.baseUrl}/team-from-tournament-group";
}

abstract class UserUrl {
  static final getPlayerDetails = "${AppUrl.baseUrl}/player-details";
  static final getFiveTournaments = "${AppUrl.baseUrl}/last-five-tournaments";
  static final getTournamentPoints = "${AppUrl.baseUrl}/tournament-points";
}
