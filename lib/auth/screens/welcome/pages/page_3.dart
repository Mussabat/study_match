import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              'assets/images/welcome/undraw_group_chat_re_frmo.svg',
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            const Text(
              'Group Study',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(103, 58, 183, 1),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            const Text(
              'Discuss, solve problems, learn and grow together with your peers.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1),
            FilledButton(
              onPressed: () => debugPrint(
                  'Clicked!'), //Navigator.of(context).pushNamed('/login'),
              child: const Text('GET STARTED'),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
