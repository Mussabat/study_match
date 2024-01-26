import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:study_match/core/core.dart';
import 'package:study_match/profile/services/services.dart';
import 'package:study_match/chat/services/chat_service.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key, required this.userID});

  final String userID;

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late Future<Profile?> profileFuture;

  @override
  void initState() {
    super.initState();
    profileFuture = ProfileService.instance.getProfile(widget.userID);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: profileFuture,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Profile'),
          ),
          body: Center(
            child: snapshot.hasData
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        (snapshot.data as Profile).username,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () async {
                                final chat = await ChatService.instance
                                    .checkIfHasChat(
                                        (snapshot.data as Profile).id);
                                if (chat != null && mounted) {
                                  context.go(
                                      '/chat/${chat.id}/${(snapshot.data as Profile).username}');
                                } else {
                                  final newChat = await ChatService.instance
                                      .createNewChat(
                                          (snapshot.data as Profile).id);
                                  if (mounted) {
                                    context.go(
                                        '/chat/${newChat.id}/${(snapshot.data as Profile).username}');
                                  }
                                }
                              },
                              icon: const Icon(Icons.chat)),
                          (snapshot.data as Profile).isFollowing
                              ? IconButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Unfollow'),
                                        content: const Text(
                                            'Are you sure you want to unfollow this user?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel')),
                                          TextButton(
                                              onPressed: () async {
                                                await ConnectionsService
                                                    .instance
                                                    .deleteConnection((snapshot
                                                            .data as Profile)
                                                        .id);
                                                setState(() {
                                                  profileFuture = ProfileService
                                                      .instance
                                                      .getProfile(
                                                          widget.userID);
                                                });
                                                if (mounted) {
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: const Text('Unfollow')),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.person_remove))
                              : IconButton(
                                  onPressed: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Follow'),
                                        content: const Text(
                                            'Are you sure you want to follow this user?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('Cancel')),
                                          TextButton(
                                              onPressed: () async {
                                                await ConnectionsService
                                                    .instance
                                                    .addConnection((snapshot
                                                            .data as Profile)
                                                        .id);
                                                setState(() {
                                                  profileFuture = ProfileService
                                                      .instance
                                                      .getProfile(
                                                          widget.userID);
                                                });
                                                if (mounted) {
                                                  Navigator.of(context).pop();
                                                }
                                              },
                                              child: const Text('Follow')),
                                        ],
                                      ),
                                    );
                                  },
                                  icon: const Icon(Icons.person_add)),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Tags',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 20),
                      ...((snapshot.data as Profile)
                          .tags
                          .map((e) => Text(e.tag))),
                    ],
                  )
                : snapshot.hasError
                    ? Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Colors.red),
                      )
                    : const CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
