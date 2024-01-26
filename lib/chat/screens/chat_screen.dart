import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_match/chat/bloc/cubit/chat_screen_cubit.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({
    super.key,
    required this.chatId,
    required this.chatName,
  });

  final String chatId;
  final String chatName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatScreenCubit(chatId),
      child: ChatScreenPage(
        chatId: chatId,
        chatName: chatName,
      ),
    );
  }
}

class ChatScreenPage extends StatefulWidget {
  const ChatScreenPage(
      {super.key, required this.chatId, required this.chatName});

  final String chatId;
  final String chatName;

  @override
  State<ChatScreenPage> createState() => _ChatScreenPageState();
}

class _ChatScreenPageState extends State<ChatScreenPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            context.go('/home');
          },
          child: const Text('Back'),
        ),
        leadingWidth: 80,
        title: Text(widget.chatName),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatScreenCubit, ChatScreenState>(
                builder: (context, state) {
                  return ListView.separated(
                    itemCount: state.chatMessages.length,
                    separatorBuilder: (context, index) =>
                        const Divider(), // Add a separator between messages
                    itemBuilder: (context, index) {
                      final message = state.chatMessages[index];
                      return ListTile(
                        title: Text(message.message),
                        subtitle: Text(message.senderUserName ??
                            'Unknown'), // Show the username of the sender
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<ChatScreenCubit>().sendMessage(
                            _messageController.text,
                          );
                    },
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
