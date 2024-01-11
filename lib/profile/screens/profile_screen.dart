import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
