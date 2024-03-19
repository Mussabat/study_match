import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:study_match/auth/authentication.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.user});

  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                CircleAvatar(
                  radius: 70,
                  child: ClipOval(
                    child: Text(
                      user.userMetadata!['username'][0],
                      style: const TextStyle(fontSize: 50),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  user.userMetadata!['username'] ?? '',
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                const Divider(),
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: _ProfileMenu(),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

final _menuOntap = [
  (BuildContext context) => context.goNamed('connections'),
  (BuildContext context) => context.goNamed('tags'),
  (BuildContext context) => context.read<LoginOutBloc>().add(LogoutSubmitted()),
];

final _menuItems = [
  'Manage Connections',
  'Manage Tags',
  'Logout',
];

final _menuIcons = [
  Icons.people,
  Icons.tag,
  Icons.logout,
];

class _ProfileMenu extends StatelessWidget {
  const _ProfileMenu();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginOutBloc, LoginOutState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          context.goNamed('sign_in');
        }
      },
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(_menuIcons[index]),
              title: Text(_menuItems[index]),
              onTap: () => _menuOntap[index](context),
            );
          },
          itemCount: _menuItems.length,
          separatorBuilder: (context, index) => const Divider(),
        );
      },
    );
  }
}
