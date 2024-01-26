import 'package:study_match/core/core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class TagService {
  final supabase = Supabase.instance.client;
  TagService._();

  static final currentUserTags = <Tag>[];

  Future<List<Tag>?> getTags(String userId) async {
    await getCurrentUserTags();
    final tagsResponse = await supabase
        .from('user_tags')
        .select('tags:tag_id(id, tag)')
        .eq('user_id', userId);

    if (tagsResponse == null) return null;

    final tagsData = tagsResponse as List<dynamic>;
    final tags = tagsData.map((e) {
      final tagData = e['tags'] as Map<String, dynamic>;
      final tag = tagData['tag'] as String;
      return Tag(
        id: tagData['id'] as String,
        tag: tag,
        isConnected:
            currentUserTags.any((element) => element.id == tagData['id']),
      );
    }).toList();

    return tags;
  }

  Future<List<Tag>?> getCurrentUserTags() async {
    final tagsResponse = await supabase
        .from('user_tags')
        .select('tags:tag_id(id, tag)')
        .eq('user_id', supabase.auth.currentUser!.id);

    if (tagsResponse == null) return null;

    final tagsData = tagsResponse as List<dynamic>;
    final tags = tagsData.map((e) {
      final tagData = e['tags'] as Map<String, dynamic>;
      final tag = tagData['tag'] as String;
      return Tag(
        id: tagData['id'] as String,
        tag: tag,
        isConnected: true,
      );
    }).toList();

    currentUserTags.clear();
    currentUserTags.addAll(tags);

    return tags;
  }

  Future<void> deleteUserTag(String tagId) async {
    await supabase.from('user_tags').delete().eq('tag_id', tagId);
  }

  Future<String?> _getTagId(String tag) async {
    final tagResponse = await supabase.from('tags').select('id').eq('tag', tag);

    if (tagResponse == null) return null;

    final tagData = tagResponse as List<dynamic>;
    final tagId = tagData.first['id'] as String;

    return tagId;
  }

  Future<void> addUserTag(String tag) async {
    if (!tag.startsWith('#')) tag = '#$tag';

    final tagId = await _getTagId(tag);
    if (tagId != null) {
      await supabase.from('user_tags').insert({
        'user_id': supabase.auth.currentUser!.id,
        'tag_id': tagId,
      });
      return;
    }

    final tagResponse = await supabase.from('tags').insert({
      'tag': tag,
    }).select('id');

    await supabase.from('user_tags').insert({
      'user_id': supabase.auth.currentUser!.id,
      'tag_id': tagResponse,
    });
  }

  static final instance = TagService._();
}
