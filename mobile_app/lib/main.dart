import 'package:bookshopapp/pages/greetings_page.dart';
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
      home: const GreetingsPage(),
    );
  }
}
