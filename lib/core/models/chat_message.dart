import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String id;
  final String senderId;
  final String? senderUserName;
  final String chatId;
  final String message;

  const ChatMessage({
    required this.id,
    required this.senderId,
    this.senderUserName,
    required this.chatId,
    required this.message,
  });

  @override
  List<Object?> get props => [id, senderId, chatId, message];
}
