import 'package:shared_preferences/shared_preferences.dart';

class Global {
  Future<void> saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_id', userId);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_id');
  }

  Future<void> removeUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user_id');
  }

  void deleteIds() async {
    final id = await getUserId();

    print('user id deleted ===>>>> $id');
  }

  String playerCacheKey = 'playersCache';
  String playerCacheTimeKey = 'playersCacheTime';

  Future<void> logoutUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.remove(playerCacheKey);
    await prefs.remove(playerCacheTimeKey);

    print("User logged out and local storage cleared.");
    await prefs.clear();
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
