import 'package:cricket_app/constent/app_color.dart';
import 'package:cricket_app/providers/add_new_player_provider.dart';
import 'package:cricket_app/providers/registration_provider.dart';
import 'package:cricket_app/providers/team_provider.dart';
import 'package:cricket_app/providers/user_login_provider.dart';
import 'package:cricket_app/routes.dart';
import 'package:cricket_app/screens/splash_screen.dart/splash_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashScreenProvider()),
        ChangeNotifierProvider(create: (context) => UserLoginProvider()),
        ChangeNotifierProvider(create: (context) => RegistrationProvider()),
        ChangeNotifierProvider(create: (context) => AddNewPlayerProvider()),
        ChangeNotifierProvider(create: (context) => TeamProvider()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cric Media',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.blueColor),
          useMaterial3: true,
        ),
        // home: const SplashScreen(),
        onGenerateRoute: Routes.onGenerateRoute,
        initialRoute: '/',
      ),
    );
  }
}
