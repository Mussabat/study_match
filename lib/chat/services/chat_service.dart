import 'package:study_match/core/models/chat.dart';
import 'package:study_match/core/models/chat_message.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatService {
  final supabase = Supabase.instance.client;
  ChatService._();

  Future<List<Chat>> getChatList() async {
    final currentUserId = supabase.auth.currentUser!.id;
    final chatResponse = await supabase
        .from('chats')
        .select()
        .or('user_1_id.eq.$currentUserId, user_2_id.eq.$currentUserId');

    if (chatResponse == null) return [];

    final chatList = ((chatResponse as List<dynamic>).map((chatData) async {
      return Chat(
        id: chatData['id'] as String,
        chatName: (await supabase
            .from('profiles')
            .select('username')
            .eq(
                'id',
                (chatData['user_1_id'] as String) == currentUserId
                    ? chatData['user_2_id']
                    : chatData['user_1_id'])
            .single())['username'] as String,
        user1Id: chatData['user_1_id'] as String,
        user2Id: chatData['user_2_id'] as String,
      );
    }).toList());

    final chatsResult = Future.wait(chatList);

    return chatsResult;
  }

  Future<Chat?> checkIfHasChat(String userId) async {
    final chatResponse = await supabase
        .from('chats')
        .select()
        .or('user_1_id.eq.$userId, user_2_id.eq.$userId')
        .limit(1);

    if (chatResponse == null) return null;

    final chatList = (chatResponse as List<dynamic>).map((chatData) {
      return Chat(
        id: chatData['id'] as String,
        user1Id: chatData['user_1_id'] as String,
        user2Id: chatData['user_2_id'] as String,
      );
    }).toList();

    return chatList.isNotEmpty ? chatList.first : null;
  }

  Future<Chat> createNewChat(String userId) async {
    final currentUserId = supabase.auth.currentUser!.id;
    final result = await supabase.from('chats').insert([
      {
        'user_1_id': currentUserId,
        'user_2_id': userId,
      },
    ]).select();

    return Chat(
      id: (result as List<dynamic>).first['id'] as String,
      user1Id: currentUserId,
      user2Id: userId,
    );
  }

  Future<void> deleteChat(String chatId) async {
    await supabase.from('chats').delete().eq('id', chatId);
  }

  Future<List<ChatMessage>> loadChatMessages(String chatId) async {
    final chatMessagesResponse = await supabase
        .from('chat_messages')
        .select()
        .eq('chat_id', chatId)
        .order('created_at', ascending: true);

    if (chatMessagesResponse == null) return [];

    final chatMessagesList =
        ((chatMessagesResponse as List<dynamic>).map((chatMessageData) {
      return ChatMessage(
        id: chatMessageData['id'] as String,
        chatId: chatMessageData['chat_id'] as String,
        senderId: chatMessageData['sender_id'] as String,
        message: chatMessageData['message'] as String,
        senderUserName: chatMessageData['sender_name'] as String?,
      );
    }).toList());

    return chatMessagesList;
  }

  Future<void> sendMessage(
      String chatId, String senderId, String message) async {
    await supabase.from('chat_messages').insert([
      {
        'chat_id': chatId,
        'sender_id': senderId,
        'message': message,
        'sender_name': Supabase
            .instance.client.auth.currentUser!.userMetadata!['username'],
      },
    ]);
  }

  static final instance = ChatService._();
}
