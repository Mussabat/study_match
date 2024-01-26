import 'package:flutter/material.dart';
import 'package:study_match/profile/profile_view.dart';
import 'package:study_match/profile/services/services.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late final Future<List<String>> _recommendedProfileIDs;

  @override
  void initState() {
    super.initState();
    _recommendedProfileIDs = ProfileService.instance.getRecommendedProfileIDs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: _recommendedProfileIDs,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.data != null && snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No profiles found'),
            );
          }

          final ids = snapshot.data as List<String>;
          return PageView.builder(
            itemCount: ids.length,
            itemBuilder: (context, index) {
              final id = ids[index];
              return ProfileView(userID: id);
            },
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    ));
  }
}
