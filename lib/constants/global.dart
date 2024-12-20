import 'package:shared_preferences/shared_preferences.dart';

class Global {
  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userId);
  }

  Future<String?> getAdminId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Future<void> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
  }

  Future<void> saveToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  void deleteIds() async {
    final id = await getAdminId();

    print('user id deleted ===>>>> $id');
  }

  String playerCacheKey = 'playersCache';
  String playerCacheTimeKey = 'playersCacheTime';

  Future<void> logoutUser(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(playerCacheKey);
    await prefs.remove(playerCacheTimeKey);
    await prefs.clear();

    // // reassign cubits
    // BlocProvider.of<AdminCubit>(context).close();
    // BlocProvider.of<PlayerCubit>(context).close();
    // BlocProvider.of<TeamCubit>(context).close();
    // BlocProvider.of<MatchCubit>(context).close();
    // BlocProvider.of<TournamentCubit>(context).close();

    // // create new instances of cubits
    // BlocProvider<AdminCubit>(
    //   create: (_) => AdminCubit(),
    // );
    // BlocProvider<PlayerCubit>(
    //   create: (_) => PlayerCubit(),
    // );
    // BlocProvider<TeamCubit>(
    //   create: (_) => TeamCubit()..getInitialTeams(),
    // );
    // BlocProvider<MatchCubit>(
    //   create: (_) => MatchCubit(),
    // );
    // BlocProvider<TournamentCubit>(
    //   create: (_) => TournamentCubit(),
    // );

    // remove all the routes
    // Routes.removeAllRoutes(context);
  }

  // Set all user info
  Future<void> setAllUserInfo(
    String name,
    String email,
    String phone,
    String password,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('email', email);
    prefs.setString('phone', phone);
    prefs.setString('password', password);
  }

  // Getters
  Future<String?> getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('name');
  }

  Future<String?> getEmail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('email');
  }

  Future<String?> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phone');
  }

  Future<String?> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password');
  }

  // Delete all user info
  Future<void> deleteAllUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('name');
    prefs.remove('email');
    prefs.remove('phone');
    prefs.remove('password');
  }
}
