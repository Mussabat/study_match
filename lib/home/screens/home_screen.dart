import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:study_match/home/home.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthRedirectBloc(),
      child: BlocConsumer<AuthRedirectBloc, AuthRedirectState>(
        listener: (context, state) {
          if (state is AuthRedirectInitial) {
            context.read<AuthRedirectBloc>().add(AuthRedirectCheck());
          }

          if (state is AuthRedirectUnauthenticated) {
            context.goNamed('welcome');
          }
        },
        builder: (context, state) {
          if (state is AuthRedirectAuthenticated) {
            return HomeScreenView(user: state.user);
          }

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key, required this.user});

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
