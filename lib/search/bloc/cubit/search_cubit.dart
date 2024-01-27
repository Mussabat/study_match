import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:study_match/core/enums/search_load_status.dart';
import 'package:study_match/search/services/search_service.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final _searchService = SearchService.instance;

  SearchCubit() : super(const SearchState([], SearchLoadStatus.initial));

  Future<void> searchUsers(String query) async {
    emit(const SearchState([], SearchLoadStatus.loading));
    if (query.isEmpty) {
      emit(const SearchState([], SearchLoadStatus.initial));
      return;
    }
    final users = await _searchService.searchUsers(query);
    emit(SearchState(users, SearchLoadStatus.loaded));
  }

  void clearSearch() {
    emit(const SearchState([], SearchLoadStatus.initial));
  }
}
