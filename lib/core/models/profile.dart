import 'package:equatable/equatable.dart';

import 'models.dart';

class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.username,
    required this.isFollowing,
    required this.tags,
  });

  final String id;
  final String username;
  final bool isFollowing;
  final List<Tag> tags;

  @override
  List<Object?> get props => [
        id,
        username,
        isFollowing,
        tags,
      ];

  Profile copyWith({
    String? id,
    String? username,
    bool? isFollowing,
    List<Tag>? tags,
  }) {
    return Profile(
      id: id ?? this.id,
      username: username ?? this.username,
      isFollowing: isFollowing ?? this.isFollowing,
      tags: tags ?? this.tags,
    );
  }
}
