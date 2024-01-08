import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_match/auth/services/services.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupSubmitted>(_onSubmitted);
  }

  Future<void> _onSubmitted(
      SignupSubmitted event, Emitter<SignupState> emit) async {
    emit(SignupLoading());

    final (_, _, exception) = await AuthService.instance.signUp(
      email: event.email,
      password: event.password,
      username: event.username,
    );

    if (exception != null) {
      emit(SignupFailure(exception.message));
      return;
    }

    emit(SignupSuccess());
  }
}
