import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_match/home/home.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_redirect_event.dart';
part 'auth_redirect_state.dart';

class AuthRedirectBloc extends Bloc<AuthRedirectEvent, AuthRedirectState> {
  final _userService = UserService();

  AuthRedirectBloc() : super(AuthRedirectInitial()) {
    on<AuthRedirectCheck>(_onCheck);
  }

  void _onCheck(AuthRedirectEvent event, Emitter<AuthRedirectState> emit) {
    final user = _userService.getUser();
    if (user != null) {
      emit(AuthRedirectAuthenticated(user: user));
    } else {
      emit(AuthRedirectUnauthenticated());
    }
  }
}
