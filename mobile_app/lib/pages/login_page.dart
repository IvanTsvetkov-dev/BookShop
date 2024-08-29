import 'package:bookshopapp/forms/signin_form.dart';
import 'package:bookshopapp/forms/signup_form.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
  ];

  @override
  void initState() {
    super.initState();
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

    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.primary,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: screenSize.height * 0.32,
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
                  child: DefaultTabController(
                      length: 2,
                      child: Column(
                        children: [
                          TabBar(
                            tabs: tabs,
                            isScrollable: false,
                            indicatorColor: Theme.of(context).colorScheme.primary,
                          ),
                          const Expanded(
                              child: TabBarView(
                                  children: [SignInForm(), SignUpForm()]))
                        ],
                      )),
                )
              ],
            )),
      ),
    );
  }
}
