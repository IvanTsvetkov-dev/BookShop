import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class GreetingsPage extends StatefulWidget {
  const GreetingsPage({super.key});

  @override
  State<GreetingsPage> createState() => _GreetingsPageState();
}

class _GreetingsPageState extends State<GreetingsPage>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                    padding: EdgeInsets.only(top: 40),
                    child: Column(
                      
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                            style: TextStyle(
                              
                                shadows: [
                                  Shadow(
                                    color: Colors
                                        .black26, // Choose the color of the shadow
                                    blurRadius:
                                        2.0, // Adjust the blur radius for the shadow effect
                                    offset: Offset(0, 4),
                                  )
                                ],
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF4F4FB),
                                fontSize: 48),
                            'Book'),
                        Text(
                            style: TextStyle(
                                shadows: [
                                  Shadow(
                                    color: Colors
                                        .black26, // Choose the color of the shadow
                                    blurRadius:
                                        2.0, // Adjust the blur radius for the shadow effect
                                    offset: Offset(0, 4),
                                  )
                                ],
                                fontWeight: FontWeight.w700,
                                color: Color(0xFFF4F4FB),
                                fontSize: 40),
                            'Shop')
                      ],
                    )),
                SizedBox(
                  height: screenSize.height * 0.4,
                  child: Lottie.asset(
                    'assets/splash.json',
                    controller: _controller,
                    onLoaded: (composition) {
                      _controller
                        ..duration = composition.duration
                        ..forward();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 80),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFFF4F4FB),
                                    fontSize: 30),
                                'GET STARTED')),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                            style: TextStyle(
                                color: Color(0xFFF4F4FB),
                                fontSize: 24,
                                fontWeight: FontWeight.w300),
                            'Buy books, be smart'),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
