import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/auth_model.dart';
import 'package:frontend/pages/game_page/pages/levels_preview_page.dart';
import 'package:frontend/pages/game_page/utils/level_switch.dart';
import 'package:frontend/pages/game_page/pages/pass_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/splash_page/splash_page.dart';
import 'package:frontend/pages/tabs_page/tabs_page.dart';
import 'package:frontend/services/user/auth_service.dart';
import 'package:frontend/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBiRJHz71YLGqOMtM0AKoJoPydWMb-WTHw",
      appId: "1:553224046241:web:42e6467edc525cbbd612e0",
      messagingSenderId: "553224046241",
      projectId: "crow-2c36b",
    ),
  );
  final SharedPreferences _prefs = await SharedPreferences.getInstance();
  AppTheme.setTheme(
      isDark: _prefs.getBool('isDarkTheme') ?? false,
      colorNum: _prefs.getInt('colorModeNum') ?? 0);

  runApp(MultiProvider(providers: [
    StreamProvider<AuthModel?>(
        initialData: null, create: (_) => AuthService().authResult)
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
        '/tabs': (context) => const TabsPage(),
        '/level': (context) => const LevelSwitch(),
        '/pass-page': (context) => const PassPage(),
        '/levels-preview-page': (context) => const LevelsPreviewPage()
      },
    );
  }
}
