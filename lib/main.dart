import 'dart:convert';

import 'package:cricket_app/constants/app_color.dart';
import 'package:cricket_app/constants/app_url.dart';
import 'package:cricket_app/providers/add_new_player_provider.dart';
import 'package:cricket_app/providers/bloc_providers.dart';
import 'package:cricket_app/providers/registration_provider.dart';
import 'package:cricket_app/providers/team_provider.dart';
import 'package:cricket_app/providers/user_login_provider.dart';
import 'package:cricket_app/routes.dart';
import 'package:cricket_app/services/notification_service.dart';
import 'package:cricket_app/services/socket_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SocketService.instance.connect();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationService().init();
  await getToken();
  runApp(const MyApp());
}

String actualToken = 'Loading...';

Future<void> getToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    token = newToken;
    _sendTokenToServer(token!);
  });
  actualToken = token ?? 'Failed to get token';
  if (token != null) {
    await _sendTokenToServer(token!);
  }
}

Future<void> _sendTokenToServer(String token) async {
  final response = await http.post(
    Uri.parse('${AppUrl.baseUrl}/superadmin/api/store-token'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'token': token,
      'userId': token,
    }),
  );
  if (response.statusCode == 200 || response.statusCode == 201) {
    print('Token sent to server');
  } else {
    print('Failed to send token to server');
  }
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
          providers: providers,
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
