import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/pages/auth_page/auth_page.dart';
import 'package:frontend/pages/auth_page/sign_in_page.dart';
import 'package:frontend/pages/game_page/game_home/game_home.dart';
import 'package:frontend/pages/game_page/level_router.dart';
import 'package:frontend/pages/home_page/home_page.dart';
import 'package:frontend/pages/settings_page/settings_page.dart';
import 'package:frontend/pages/splash_page/splash_page.dart';
import 'package:frontend/pages/statistics_page/statistics_page.dart';
import 'package:frontend/pages/tabs_page.dart';
import 'package:frontend/services/auth_service.dart';
import 'package:frontend/utils/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    currentTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      value: AuthService().user,
      initialData: null,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: currentTheme.currentTheme,
        routes: {
          '/': (context) => SplashPage(),
          '/home': (context) => HomePage(),
          '/auth': (context) => AuthPage(),
          '/tabs': (context) => TabsPage(),
          '/statistics': (context) => const StatisticsPage(),
          '/settings': (context) => const SettingsPage(),
          '/level': (context) => const LevelRouter(),
          '/game-home': (context) => const GameHome()
        },
      ),
    );
  }
}
