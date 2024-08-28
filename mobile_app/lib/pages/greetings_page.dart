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
                    padding: EdgeInsets.only(top: 50),
                    child: Column(
                      children: [
                        Text(
                            style: TextStyle(
                                color: Color(0xFFF4F4FB), fontSize: 52),
                            'Book'),
                        Text(
                            style: TextStyle(
                                color: Color(0xFFF4F4FB), fontSize: 40),
                            'Shop')
                      ],
                    )),
                Container(
                  width: 300,
                  height: 300,
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
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Text(
                                style: TextStyle(
                                    color: Color(0xFFF4F4FB), fontSize: 32),
                                'GET STARTED')),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                            style: TextStyle(
                                color: Color(0xFFF4F4FB),
                                fontSize: 28,
                                fontWeight: FontWeight.w100),
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
