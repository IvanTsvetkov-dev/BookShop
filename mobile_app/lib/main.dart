import 'package:bookshopapp/pages/greetings_page.dart';
import 'package:bookshopapp/pages/home_page.dart';
import 'package:bookshopapp/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EntryPoint());
}

class EntryPoint extends StatelessWidget {
  const EntryPoint({super.key});

  @override
  Widget build(BuildContext context) {
    const ColorScheme colorScheme = ColorScheme.light(
        primary: Color(0xFF5E69EE),
        secondary: Color.fromARGB(100, 57, 175, 234));

    const String initialRoute = '/';



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
        '/' : (context) => const GreetingsPage(),
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage()
      },
    );
  }
}
