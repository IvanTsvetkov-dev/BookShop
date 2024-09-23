import 'package:bookshopapp/api%5Blegacy%5D/server_api.dart';
import 'package:bookshopapp/core/app_enviroment.dart';
import 'package:bookshopapp/core/exception/unauthorized_exception.dart';
import 'package:bookshopapp/presentation/pages/greetings_page.dart';
import 'package:bookshopapp/presentation/pages/home_page.dart';
import 'package:bookshopapp/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final refreshToken = prefs.getString('refresh_token') ?? '';
  AppEnviroment.serverHost = prefs.getString('server_host') ?? '';
  String initialRoute = '/greetings';

  if (refreshToken != '') {
    AppEnviroment.tokens.refresh = refreshToken;
    initialRoute = '/home';

    try {
      final accessToken = await updateAccessToken(refreshToken);
      AppEnviroment.tokens.access = accessToken;
    } on UnauthorizedException catch (e) {
      initialRoute = '/login';
    }
  }

  runApp(EntryPoint(initialRoute: initialRoute));
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key, required this.initialRoute});

  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    const ColorScheme colorScheme = ColorScheme.light(
        primary: Color(0xFF5E69EE),
        secondary: Color.fromARGB(100, 57, 175, 234));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Roboto',
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF39AFEA))),
          colorScheme: colorScheme,
          textTheme: const TextTheme(
              displayLarge:
                  TextStyle(fontSize: 72, fontWeight: FontWeight.bold))),
      initialRoute: initialRoute,
      routes: {
        '/greetings': (context) => const GreetingsPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
