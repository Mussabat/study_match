import 'package:supabase_flutter/supabase_flutter.dart';

class ConnectionsService {
  final supabase = Supabase.instance.client;
  ConnectionsService._();

  Future<List<dynamic>?> getConnections() async {
    final response = await supabase
        .from('connections')
        .select('profiles:to_id(id, username)')
        .order(
          'profiles(username)',
          ascending: true,
        );

    if (response == null) return [];

    final data = response as List<dynamic>;
    return data;
  }

  Future<void> deleteConnection(String id) async {
    await supabase
        .from('connections')
        .delete()
        .eq('from_id', supabase.auth.currentUser!.id)
        .eq('to_id', id);
  }

  Future<void> addConnection(String id) async {
    await supabase.from('connections').insert({
      'from_id': supabase.auth.currentUser!.id,
      'to_id': id,
    });
  }

  static final instance = ConnectionsService._();
}
