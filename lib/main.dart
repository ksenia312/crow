import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/models/user_model.dart';
import 'package:frontend/pages/auth_page/auth_page.dart';
import 'package:frontend/pages/game_page/game_home/game_home.dart';
import 'package:frontend/pages/game_page/level_router.dart';
import 'package:frontend/pages/game_page/pass_page.dart';
import 'package:frontend/pages/home_page/home_page.dart';
import 'package:frontend/pages/settings_page/settings_page.dart';
import 'package:frontend/pages/splash_page/splash_page.dart';
import 'package:frontend/pages/statistics_page/statistics_page.dart';
import 'package:frontend/pages/tabs_page.dart';
import 'package:frontend/pages/wrapper/wrapper.dart';
import 'package:frontend/services/user/database.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  AppTheme.setTheme(
      isDark: _prefs.getBool('isDarkTheme') ?? false,
      colorNum: _prefs.getInt('colorModeNum') ?? 0);

  runApp(MultiProvider(providers: [
    StreamProvider<AuthModel?>(
        initialData: null, create: (_) => AuthService().user)
  ], child: const MyApp()));
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
    appTheme.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: appTheme.light,
      darkTheme: appTheme.dark,
      themeMode: appTheme.currentTheme,
      routes: {
        '/': (context) => const SplashPage(),
        '/home': (context) => HomePage(),
        '/wrapper': (context) => const Wrapper(),
        '/auth': (context) => const AuthPage(),
        '/tabs': (context) => const TabsPage(),
        '/statistics': (context) => const StatisticsPage(),
        '/settings': (context) => const SettingsPage(),
        '/level': (context) => const LevelRouter(),
        '/pass-page': (context) => const PassPage(),
        '/game-home': (context) => const GameHome()
      },
    );
  }
}
