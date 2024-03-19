import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_match/auth/services/services.dart';

part 'login_out_event.dart';
part 'login_out_state.dart';

class LoginOutBloc extends Bloc<LoginOutEvent, LoginOutState> {
  LoginOutBloc() : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutSubmitted>(_onLogoutSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginOutState> emit,
  ) async {
    emit(LoginLoading());

    final (_, _, exception) = await AuthService.instance.logIn(
      email: event.email,
      password: event.password,
    );

    if (exception != null) {
      emit(LoginFailure(exception.message));
      return;
    }

    emit(LoginSuccess());
  }

  Future<void> _onLogoutSubmitted(
    LogoutSubmitted event,
    Emitter<LoginOutState> emit,
  ) async {
    emit(LogoutLoading());
    await AuthService.instance.logOut();
    emit(LogoutSuccess());
  }
}
