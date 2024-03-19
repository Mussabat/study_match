import 'package:flutter/material.dart';
import 'package:study_match/core/core.dart';
import 'package:study_match/profile/services/tag_service.dart';

class TagsScreen extends StatefulWidget {
  const TagsScreen({super.key});

  @override
  State<TagsScreen> createState() => _TagsScreenState();
}

class _TagsScreenState extends State<TagsScreen> {
  var _tags = TagService.instance.getCurrentUserTags();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tags'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
            context: context,
            builder: (context) {
              final tagController = TextEditingController();
              return AlertDialog(
                title: const Text('Add Tag'),
                content: TextField(
                  controller: tagController,
                  decoration: const InputDecoration(
                    labelText: 'Tag',
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      final tag = tagController.text;
                      if (tag.isNotEmpty) {
                        await TagService.instance.addUserTag(tag);
                        if (mounted) Navigator.of(context).pop();
                        setState(() {
                          _tags = TagService.instance.getCurrentUserTags();
                        });
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder(
        future: _tags,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          if (snapshot.hasData) {
            final tags = snapshot.data as List<Tag>;
            debugPrint(tags.toString());
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.separated(
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  final tag = tags[index];
                  return ListTile(
                    title: Text(tag.tag),
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
                              title: const Text('Delete Tag'),
                              content: const Text(
                                  'Are you sure you want to delete this tag?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    await TagService.instance
                                        .deleteUserTag(tag.id);
                                    if (mounted) Navigator.of(context).pop();
                                    setState(() {
                                      tags.removeAt(index);
                                    });
                                  },
                                  child: const Text('Delete'),
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
