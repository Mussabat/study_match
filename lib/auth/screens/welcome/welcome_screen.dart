import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:study_match/auth/screens/welcome/login_page.dart';
import 'package:study_match/auth/screens/welcome/welcome_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int _currentPage = 0;
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: const [
                  WelcomePage(),
                  LoginPage(),
                ],
              ),
            ),
            DotsIndicator(
              dotsCount: 2,
              position: _currentPage,
            ),
          ],
        ),
      ),
    );
  }
}
