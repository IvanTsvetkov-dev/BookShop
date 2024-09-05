import 'package:bookshopapp/api/server_api.dart' as server_api;
import 'package:bookshopapp/forms/settings_form.dart';
import 'package:bookshopapp/forms/signin_form.dart';
import 'package:bookshopapp/forms/signup_form.dart';
import 'package:bookshopapp/widgets/login_styled_text_field.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  late final AnimationController _lottieController;
  late TabController _tabController;
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Sign In'),
    Tab(text: 'Sign Up'),
    Tab(
      text: 'Settings',
    )
  ];

  void loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final host = prefs.getString('server_host') ?? 'localhost';
    server_api.serverHost = host;
  }

  @override
  void initState() {
    super.initState();
    loadSettings();
    _tabController = TabController(length: 2, vsync: this);
    _lottieController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Похорошему сделать бы какой-то singleton, который содержит эту инфу(?)
    Size screenSize = MediaQuery.sizeOf(context);
    EdgeInsets screenPadding = MediaQuery.of(context).padding;
    const Color borderColor = Color.fromARGB(153, 94, 105, 238);
    const Color hintColor = Color.fromARGB(153, 94, 105, 238);
    const Color textColor = Color.fromARGB(255, 94, 106, 238);

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
              height: MediaQuery.sizeOf(context).height -
                  screenPadding.bottom -
                  screenPadding.top,
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: screenSize.height * 0.3,
                        child: Lottie.asset('assets/signup.json'),
                      ),
                      const Text(
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
                              fontSize: 42),
                          'Book shop')
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    width: screenSize.width,
                    height: screenSize.height * 0.55,
                    child: const DefaultTabController(
                        length: 3,
                        child: Column(
                          children: [
                            TabBar(
                              tabs: tabs,
                              isScrollable: false,
                              indicatorColor: Color.fromARGB(224, 94, 106, 238),
                              dividerColor: Colors.transparent,
                            ),
                            Expanded(
                                child: TabBarView(children: [
                              Center(child: SignInForm()),
                              Center(child: SignUpForm()),
                              Center(child: HostSettginsForm())
                            ]))
                          ],
                        )),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
