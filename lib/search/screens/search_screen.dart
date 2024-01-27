import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_match/core/enums/search_load_status.dart';
import 'package:study_match/profile/profile_view.dart';
import 'package:study_match/search/bloc/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: const SearchPage(),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search for a user',
                    ),
                    onChanged: (value) {
                      context.read<SearchCubit>().searchUsers(value);
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    context.read<SearchCubit>().clearSearch();
                  },
                ),
              ],
            ),
          ),
          body: _showSearchResults(context, state),
        );
      },
    );
  }
}

Widget _showSearchResults(BuildContext context, SearchState state) {
  if (state.status == SearchLoadStatus.loading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (state.status == SearchLoadStatus.loaded) {
    return ListView.builder(
      itemCount: state.users.length,
      itemBuilder: (context, index) {
        final user = state.users[index];
        return ListTile(
          title: Text(user.$2),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ProfileView(userID: user.$1),
            ),
          ),
        );
      },
    );
  }

  return const Center(
    child: Text('Your search results will appear here!'),
  ); //
}
