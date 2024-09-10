import 'package:bookshopapp/api/globals.dart' as globals;
import 'package:bookshopapp/api/server_api.dart';
import 'package:bookshopapp/api/unauthorized_exception.dart';
import 'package:bookshopapp/pages/cart_page.dart';
import 'package:bookshopapp/pages/greetings_page.dart';
import 'package:bookshopapp/pages/home_page.dart';
import 'package:bookshopapp/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();
  final refreshToken = prefs.getString('refresh_token') ?? '';
  globals.serverHost = prefs.getString('server_host') ?? '';
  String initialRoute = '/greetings';

  if (refreshToken != '') {
    globals.refreshToken = refreshToken;
    initialRoute = '/home';

    try {
      final accessToken = await updateAccessToken(refreshToken);
      globals.accesToken = accessToken;
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
        '/cart': (context) => const CartPage()
      },
    );
  }
}
