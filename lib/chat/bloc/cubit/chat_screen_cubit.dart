import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_match/chat/services/chat_service.dart';
import 'package:study_match/core/models/chat_message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'chat_screen_state.dart';

class ChatScreenCubit extends Cubit<ChatScreenState> {
  final ChatService _chatService = ChatService.instance;
  final String chatId;
  late final StreamSubscription _chatSubscription;

  ChatScreenCubit(this.chatId) : super(const ChatScreenState([])) {
    loadChatMessages(chatId);
    _chatSubscription = Supabase.instance.client
        .from('chat_messages')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: true)
        .eq('chat_id', chatId)
        .listen(
          (List<Map<String, dynamic>> data) {
            emit(
              ChatScreenState(
                data
                    .map((e) => ChatMessage(
                          id: e['id'] as String,
                          senderId: e['sender_id'] as String,
                          senderUserName: e['sender_name'] as String?,
                          chatId: e['chat_id'] as String,
                          message: e['message'] as String,
                        ))
                    .toList(),
              ),
            );
          },
        );
  }

  void addMessage(ChatMessage message) {
    final newChatMessages = List<ChatMessage>.from(state.chatMessages)
      ..add(message);
    emit(ChatScreenState(newChatMessages));
  }

  Future<void> loadChatMessages(String chatId) async {
    final newChatMessages = await _chatService.loadChatMessages(chatId);
    emit(ChatScreenState(newChatMessages));
  }

  Future<void> sendMessage(String message) async {
    final currentUserId = Supabase.instance.client.auth.currentUser!.id;
    await _chatService.sendMessage(chatId, currentUserId, message);
  }

  @override
  Future<void> close() {
    _chatSubscription.cancel();
    return super.close();
  }
}
