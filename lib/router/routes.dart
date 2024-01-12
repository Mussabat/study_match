import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_match/auth/authentication.dart';
import 'package:study_match/explore/screens/explore_screen.dart';
import 'package:study_match/home/home.dart';
import 'package:study_match/profile/screens/screens.dart';
import 'package:study_match/router/navbar.dart';
import 'package:study_match/search/search.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
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
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ScaffoldWithNavBar(
        child: child,
      ),
      routes: [
        GoRoute(
          name: 'home',
          path: '/home',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          name: 'search',
          path: '/search',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const SearchScreen(),
        ),
        GoRoute(
          name: 'explore',
          path: '/explore',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) => const ExploreScreen(),
        ),
        GoRoute(
          name: 'profile',
          path: '/profile',
          parentNavigatorKey: _shellNavigatorKey,
          builder: (context, state) =>
              ProfileScreen(user: Supabase.instance.client.auth.currentUser!),
          routes: [
            GoRoute(
              name: 'connections',
              path: 'connections',
              builder: (context, state) => const ConnectionsScreen(),
            ),
          ],
        )
      ],
    )
  ],
);
