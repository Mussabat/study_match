import 'package:supabase_flutter/supabase_flutter.dart';

class SearchService {
  final supabase = Supabase.instance.client;
  SearchService._();

  Future<List<(String, String)>> searchUsers(String query) async {
    final response = await supabase
        .from('profiles')
        .select('id, username')
        .ilike('username', '%$query%');

    if (response == []) return [];

    final data = response as List<dynamic>;
    final users = data.map((e) {
      final userData = e as Map<String, dynamic>;
      return (userData['id'] as String, userData['username'] as String);
    }).toList();

    return users;
  }

  static final SearchService instance = SearchService._();
}
