import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_match/core/enums/chats_load_status.dart';
import 'package:study_match/home/bloc/cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HomeCubit(),
        child: const HomeScreenView(),
      ),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state.chatsLoadStatus == ChatsLoadStatus.loaded) {
              return ListView.builder(
                itemCount: state.chatList.length,
                itemBuilder: (context, index) {
                  final chat = state.chatList[index];
                  return ListTile(
                    title: Text(chat.chatName ?? 'Unknown chat'),
                    onTap: () {
                      context.go('/chat/${chat.id}/${chat.chatName}');
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<HomeCubit>().deleteChat(chat.id);
                      },
                    ),
                  );
                },
              );
            } else if (state.chatsLoadStatus == ChatsLoadStatus.error) {
              return const Center(
                child: Text('Error loading chats'),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
