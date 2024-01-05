import 'package:go_router/go_router.dart';
import 'package:study_match/auth/screens/sign_in/sign_in_screen.dart';
import 'package:study_match/auth/screens/welcome/welcome_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/sign_in',
      builder: (context, state) => const SignInScreen(),
    ),
  ],
);
