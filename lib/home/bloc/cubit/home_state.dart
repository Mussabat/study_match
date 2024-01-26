part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.chatsLoadStatus,
    this.chatList = const [],
  });

  final ChatsLoadStatus chatsLoadStatus;
  final List<Chat> chatList;

  @override
  List<Object> get props => [chatsLoadStatus, chatList];
}
