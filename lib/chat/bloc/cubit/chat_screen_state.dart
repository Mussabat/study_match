part of 'chat_screen_cubit.dart';

class ChatScreenState extends Equatable {
  const ChatScreenState(this.chatMessages);

  final List<ChatMessage> chatMessages;

  @override
  List<Object> get props => [chatMessages];
}
