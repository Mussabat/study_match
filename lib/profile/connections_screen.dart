import 'package:flutter/material.dart';
import 'package:study_match/profile/profile_view.dart';
import 'package:study_match/profile/services/services.dart';

class ConnectionsScreen extends StatefulWidget {
  const ConnectionsScreen({super.key});

  @override
  State<ConnectionsScreen> createState() => _ConnectionsScreenState();
}

class _ConnectionsScreenState extends State<ConnectionsScreen> {
  final _connections = ConnectionsService.instance.getConnections();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connections'),
      ),
      body: FutureBuilder(
        future: _connections,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            final connections = snapshot.data as List<dynamic>;
            debugPrint(connections.toString());
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemCount: connections.length,
                itemBuilder: (context, index) {
                  final connection = connections[index];
                  return ListTile(
                    title: Text(connection['profiles']['username']),
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            ProfileView(userID: connection['profiles']['id']))),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete Connection'),
                              content: const Text(
                                  'Are you sure you want to delete this connection?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await ConnectionsService.instance
                                        .deleteConnection(
                                            connection['profiles']['id']);
                                    setState(() {
                                      connections.removeAt(index);
                                    });
                                    if (mounted) Navigator.of(context).pop();
                                  },
                                  child: const Text(
                                    'Delete',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
