import 'package:study_match/core/core.dart';
import 'package:study_match/profile/services/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileService {
  final supabase = Supabase.instance.client;
  ProfileService._();

  Future<Profile?> getProfile(String id) async {
    final userNameResponse =
        await supabase.from('profiles').select().eq('id', id).single();

    if (userNameResponse == null) return null;

    final data = userNameResponse as Map<String, dynamic>;
    final username = data['username'] as String;

    final isFollowingResponse = await supabase
        .from('connections')
        .select()
        .eq('to_id', id)
        .limit(1) as List<dynamic>;

    final isFollowing = isFollowingResponse.isNotEmpty;

    final tags = await TagService.instance.getTags(id);

    return Profile(
      id: id,
      username: username,
      tags: tags ?? [],
      isFollowing: isFollowing,
    );
  }

  Future<List<String>> getRecommendedProfileIDs() async {
    final connectedProfiles = await supabase
        .from('connections')
        .select('to_id')
        .then((res) => res.map((e) => e['to_id']).toList());
    final response = await supabase
        .from('profiles')
        .select('id')
        .not('id', 'in', connectedProfiles)
        .limit(30);

    if (response == null) return [];

    final data = response as List<dynamic>;
    final ids = data.map((e) => e['id'] as String).toList();

    ids.remove(supabase.auth.currentUser!.id);

    return ids;
  }

  static final instance = ProfileService._();
}
