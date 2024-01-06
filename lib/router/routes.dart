import 'package:go_router/go_router.dart';
import 'package:study_match/auth/screens/sign_in/sign_in_screen.dart';
import 'package:study_match/auth/screens/sign_in/sign_up_screen.dart';
import 'package:study_match/auth/screens/welcome/welcome_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: 'welcome',
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      name: 'sign_in',
      path: '/sign_in',
      builder: (context, state) => const SignInScreen(),
      routes: [
        GoRoute(
          name: 'sign_up',
          path: 'sign_up',
          builder: (context, state) => const SignUpScreen(),
        ),
      ],
    ),
  ],
);
