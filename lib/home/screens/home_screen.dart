import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_match/auth/authentication.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:study_match/home/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeScreenView(user: UserService.instance.getUser()!);
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService.instance.logOut();
              if (context.mounted) context.goNamed('sign_in');
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Text(
          user.userMetadata?['username'] != null
              ? 'Welcome, ${user.userMetadata?['username']} 🎉'
              : 'No username 😞',
        ),
      ),
    );
  }
}
