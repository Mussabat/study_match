part of 'search_cubit.dart';

class SearchState extends Equatable {
  final List<(String, String)> users;
  final SearchLoadStatus status;

  const SearchState(this.users, this.status);

  @override
  List<Object> get props => [users, status];
}
