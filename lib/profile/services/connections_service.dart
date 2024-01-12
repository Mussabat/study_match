import 'package:supabase_flutter/supabase_flutter.dart';

class ConnectionsService {
  final supabase = Supabase.instance.client;
  ConnectionsService._();

  Future<List<dynamic>?> getConnections() async {
    final response =
        await supabase.from('connections').select('profiles:to_id(username)');

    if (response == null) return null;

    final data = response as List<dynamic>;
    return data;
  }

  static final instance = ConnectionsService._();
}
