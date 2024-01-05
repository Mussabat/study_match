import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              'assets/images/welcome/undraw_swipe_profiles_re_tvqm.svg',
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            const Text(
              'Welcome to StudyMatch!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(103, 58, 183, 1),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Text(
              'Find your ideal study-partners, from anywhere in the world.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.2),
          ],
        ),
      ),
    );
  }
}
