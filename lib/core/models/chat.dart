import 'package:equatable/equatable.dart';

class Chat extends Equatable {
  final String id;
  final String? chatName;
  final String user1Id;
  final String user2Id;

  const Chat({
    required this.id,
    this.chatName,
    required this.user1Id,
    required this.user2Id,
  });

  @override
  List<Object?> get props => [
        id,
        user1Id,
        user2Id,
      ];

  Chat copyWith({
    String? id,
    String? user1Id,
    String? user2Id,
  }) {
    return Chat(
      id: id ?? this.id,
      user1Id: user1Id ?? this.user1Id,
      user2Id: user2Id ?? this.user2Id,
    );
  }
}
