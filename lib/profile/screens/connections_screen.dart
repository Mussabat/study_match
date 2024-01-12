import 'package:flutter/material.dart';
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
            return ListView.builder(
              itemCount: connections.length,
              itemBuilder: (context, index) {
                final connection = connections[index];
                return ListTile(
                  title: Text(connection['profiles']['username']),
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
