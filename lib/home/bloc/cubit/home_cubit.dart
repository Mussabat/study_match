import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_match/chat/services/chat_service.dart';
import 'package:study_match/core/enums/chats_load_status.dart';
import 'package:study_match/core/models/chat.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final _chatService = ChatService.instance;

  HomeCubit()
      : super(const HomeState(chatsLoadStatus: ChatsLoadStatus.unknown)) {
    loadChats();
  }

  Future<void> loadChats() async {
    emit(const HomeState(chatsLoadStatus: ChatsLoadStatus.loading));

    final chatList = await _chatService.getChatList();
    emit(
      HomeState(
        chatsLoadStatus: ChatsLoadStatus.loaded,
        chatList: chatList,
      ),
    );
  }

  Future<void> deleteChat(String chatId) async {
    await _chatService.deleteChat(chatId);
    loadChats();
  }
}
